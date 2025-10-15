<?php
/**
 * 使用Swoole多进程配合文件锁生成唯一ID插入商品浏览记录
 *
 * 本脚本利用Swoole的多进程能力配合文件锁机制生成唯一ID，
 * 高效插入1000万条商品浏览记录
 *
 * 数据表结构：
 * CREATE TABLE `product_views` (
 *   `id` bigint unsigned NOT NULL,
 *   `user_id` int unsigned NOT NULL,
 *   `product_id` int unsigned NOT NULL,
 *   `view_time` datetime NOT NULL,
 *   PRIMARY KEY (`view_id`),
 *   KEY `idx_user_id` (`user_id`),
 *   KEY `idx_product_id` (`product_id`),
 *   KEY `idx_view_time` (`view_time`)
 * ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
 */

// 检查Swoole扩展是否已安装
if (!extension_loaded('swoole')) {
    die("错误: 请先安装Swoole扩展\n");
}

class ProductViewInserterWithFileId {
    private $dbConfig;
    private $insertConfig;
    private $processCount;
    private $totalRecords;
    private $recordsPerProcess;
    private $startTime;
    private $sharedMemory;
    private $idFile;
    private $lockFile;

    public function __construct() {
        // 数据库配置
        $this->dbConfig = [
            'host' => '192.168.109.129:58066',
            'dbname' => 'mycat_testdb',
            'username' => 'root',
            'password' => '123456',
            'charset' => 'utf8mb4'
        ];

        // 插入配置
        $this->insertConfig = [
            'batchSize' => 1000, // 每次批量插入的记录数
            'maxUserId' => 500000, // 最大用户ID（模拟50万用户）
            'maxProductId' => 300000 // 最大商品ID（模拟30万商品）
        ];

        // 进程配置
        $this->processCount = 8; // 使用8个进程
        $this->totalRecords = 10000000; // 1000万条记录
        $this->recordsPerProcess = (int)($this->totalRecords / $this->processCount);

        // 共享内存存储统计信息
        $this->sharedMemory = new Swoole\Atomic(0);

        // 文件锁相关配置
        $this->idFile = '/tmp/product_view_id_counter.txt';
        $this->lockFile = '/tmp/product_view_id_counter.lock';

        // 初始化ID文件
        $this->initIdFile();
    }

    /**
     * 初始化ID文件
     */
    private function initIdFile() {
        // 获取当前表中最大的ID值，从该值开始递增
        try {
            $dsn = "mysql:host={$this->dbConfig['host']};dbname={$this->dbConfig['dbname']};charset={$this->dbConfig['charset']}";
            $pdo = new PDO($dsn, $this->dbConfig['username'], $this->dbConfig['password']);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

            $stmt = $pdo->query("SELECT COALESCE(MAX(id), 0) as max_id FROM product_views");
            $result = $stmt->fetch();
            $maxId = (int)$result['max_id'];

            // 写入初始ID值
            file_put_contents($this->idFile, $maxId);
            echo "ID文件初始化为: {$maxId}\n";
        } catch (PDOException $e) {
            echo "初始化ID文件失败: " . $e->getMessage() . "\n";
        }
    }

    /**
     * 获取下一个唯一ID
     */
    private function getNextId($count = 1) {
        $id = 0;

        // 创建锁文件
        $lockHandle = fopen($this->lockFile, 'w');
        if (!$lockHandle) {
            throw new Exception("无法创建锁文件");
        }

        // 尝试获取排他锁
        if (!flock($lockHandle, LOCK_EX)) {
            fclose($lockHandle);
            throw new Exception("无法获取文件锁");
        }

        try {
            // 读取当前ID
            $currentId = (int)file_get_contents($this->idFile);

            // 计算新的ID
            $id = $currentId + 1;

            // 更新文件中的ID
            file_put_contents($this->idFile, $id + $count - 1);
        } catch (Exception $e) {
            flock($lockHandle, LOCK_UN);
            fclose($lockHandle);
            throw $e;
        }

        // 释放锁
        flock($lockHandle, LOCK_UN);
        fclose($lockHandle);

        return $id;
    }

    /**
     * 批量获取唯一ID
     */
    private function getNextIds($count) {
        $ids = [];

        // 创建锁文件
        $lockHandle = fopen($this->lockFile, 'w');
        if (!$lockHandle) {
            throw new Exception("无法创建锁文件");
        }

        // 尝试获取排他锁
        if (!flock($lockHandle, LOCK_EX)) {
            fclose($lockHandle);
            throw new Exception("无法获取文件锁");
        }

        try {
            // 读取当前ID
            $currentId = (int)file_get_contents($this->idFile);

            // 生成ID数组
            for ($i = 0; $i < $count; $i++) {
                $ids[] = $currentId + $i + 1;
            }

            // 更新文件中的ID
            file_put_contents($this->idFile, $currentId + $count);
        } catch (Exception $e) {
            flock($lockHandle, LOCK_UN);
            fclose($lockHandle);
            throw $e;
        }

        // 释放锁
        flock($lockHandle, LOCK_UN);
        fclose($lockHandle);

        return $ids;
    }

    /**
     * 启动插入任务
     */
    public function start() {
        echo "开始使用Swoole多进程纯PHP生成唯一ID插入商品浏览记录...\n";
        echo "目标记录数: {$this->totalRecords}\n";
        echo "进程数量: {$this->processCount}\n";
        echo "每进程记录数: {$this->recordsPerProcess}\n";
        echo "批量大小: {$this->insertConfig['batchSize']}\n";
        echo "最大用户ID: {$this->insertConfig['maxUserId']}\n";
        echo "最大商品ID: {$this->insertConfig['maxProductId']}\n\n";

        $this->startTime = microtime(true);

        $pool = new Swoole\Process\Pool($this->processCount);

        $pool->on("WorkerStart", function ($pool, $workerId) {
            // 每个进程独立连接数据库
            try {
                $dsn = "mysql:host={$this->dbConfig['host']};dbname={$this->dbConfig['dbname']};charset={$this->dbConfig['charset']}";
                $pdo = new PDO($dsn, $this->dbConfig['username'], $this->dbConfig['password']);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                echo "进程 {$workerId} 数据库连接失败: " . $e->getMessage() . "\n";
                return;
            }

            // 计算当前进程的记录范围
            $startRecord = $workerId * $this->recordsPerProcess;
            $endRecord = ($workerId === $this->processCount - 1)
                ? $this->totalRecords
                : ($workerId + 1) * $this->recordsPerProcess;

            $recordsToInsert = $endRecord - $startRecord;
            $batches = ceil($recordsToInsert / $this->insertConfig['batchSize']);

            echo "进程 {$workerId} 开始插入 {$recordsToInsert} 条记录\n";

            for ($batch = 0; $batch < $batches; $batch++) {
                $recordsInBatch = min($this->insertConfig['batchSize'],
                    $recordsToInsert - ($batch * $this->insertConfig['batchSize']));

                try {
                    // 批量获取唯一ID
                    $ids = $this->getNextIds($recordsInBatch);

                    $batchRecords = [];
                    for ($i = 0; $i < $recordsInBatch; $i++) {
                        $recordIndex = $startRecord + ($batch * $this->insertConfig['batchSize']) + $i;

                        if ($recordIndex >= $endRecord) {
                            break;
                        }

                        // 使用获取到的唯一ID
                        $id = $ids[$i];

                        // 随机生成用户ID和商品ID
                        $userId = rand(1, $this->insertConfig['maxUserId']);
                        $productId = rand(1, $this->insertConfig['maxProductId']);

                        // 生成随机时间（最近300天内的随机时间）
                        $randomTimestamp = time() - rand(0, 300 * 24 * 60 * 60);
                        $viewTime = date('Y-m-d H:i:s', $randomTimestamp);

                        $batchRecords[] = "({$id}, {$userId}, {$productId}, '{$viewTime}')";
                    }

                    if (!empty($batchRecords)) {
                        $sql = "INSERT INTO product_views (id, user_id, product_id, view_time) VALUES " . implode(', ', $batchRecords);

                        try {
                            $stmt = $pdo->prepare($sql);
                            $stmt->execute();

                            // 原子性更新共享计数器
                            $this->sharedMemory->add(count($batchRecords));

                            // 每插入100000条记录显示一次进度
                            $currentTotal = $this->sharedMemory->get();
                            if ($currentTotal % 100000 === 0) {
                                $progress = round(($currentTotal / $this->totalRecords) * 100, 2);
                                $elapsedTime = round(microtime(true) - $this->startTime, 2);
                                $rate = round($currentTotal / $elapsedTime, 2);

                                echo "总进度: {$currentTotal}/{$this->totalRecords} ({$progress}%) ";
                                echo "| 用时: {$elapsedTime}s | 速度: {$rate} 条/秒\n";
                            }
                        } catch (PDOException $e) {
                            echo "进程 {$workerId} 批量插入失败: " . $e->getMessage() . "\n";
                            echo "SQL: " . $sql . "\n";
                        }
                    }
                } catch (Exception $e) {
                    echo "进程 {$workerId} 获取ID失败: " . $e->getMessage() . "\n";
                }
            }

            echo "进程 {$workerId} 完成插入任务\n";
        });

        $pool->on("WorkerStop", function ($pool, $workerId) {
            echo "进程 {$workerId} 已停止\n";
        });

        $pool->start();

        $endTime = microtime(true);
        $executionTime = round($endTime - $this->startTime, 2);
        $finalCount = $this->sharedMemory->get();
        $finalRate = $executionTime > 0 ? round($finalCount / $executionTime, 2) : 0;

        echo "\n\n所有进程完成插入任务!\n";
        echo "总用时: {$executionTime} 秒\n";
        echo "实际插入: {$finalCount} 条记录\n";
        echo "平均速度: {$finalRate} 条/秒\n";

        // 验证数据库中的记录数
        $this->verifyRecords();

        // 显示最终ID值
        $finalId = (int)file_get_contents($this->idFile);
        echo "最终ID值: {$finalId}\n";

        // 清理临时文件
        @unlink($this->idFile);
        @unlink($this->lockFile);
    }

    /**
     * 验证数据库中的记录数
     */
    private function verifyRecords() {
        try {
            $dsn = "mysql:host={$this->dbConfig['host']};dbname={$this->dbConfig['dbname']};charset={$this->dbConfig['charset']}";
            $pdo = new PDO($dsn, $this->dbConfig['username'], $this->dbConfig['password']);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

            $stmt = $pdo->query("SELECT COUNT(*) as count FROM product_views");
            $result = $stmt->fetch();
            $dbCount = $result['count'];

            echo "数据库验证记录数: {$dbCount} 条\n";

            if ($dbCount == $this->totalRecords) {
                echo "验证通过: 记录数与目标一致\n";
            } else {
                echo "验证失败: 记录数不匹配\n";
            }
        } catch (PDOException $e) {
            echo "验证失败: " . $e->getMessage() . "\n";
        }
    }

    /**
     * 获取数据库信息
     */
    public function getDbInfo() {
        try {
            $dsn = "mysql:host={$this->dbConfig['host']};dbname={$this->dbConfig['dbname']};charset={$this->dbConfig['charset']}";
            $pdo = new PDO($dsn, $this->dbConfig['username'], $this->dbConfig['password']);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

            $info = [];

            // 获取表信息
            $stmt = $pdo->query("SHOW TABLE STATUS LIKE 'product_views'");
            $tableInfo = $stmt->fetch();

            if ($tableInfo) {
                $info['rows'] = $tableInfo['Rows'];
                $info['data_length'] = $this->formatBytes($tableInfo['Data_length']);
                $info['index_length'] = $this->formatBytes($tableInfo['Index_length']);
            }

            // 获取数据库版本
            $versionStmt = $pdo->query("SELECT VERSION() as version");
            $versionInfo = $versionStmt->fetch();
            $info['version'] = $versionInfo['version'];

            return $info;
        } catch (PDOException $e) {
            return ['error' => $e->getMessage()];
        }
    }

    /**
     * 格式化字节数
     */
    private function formatBytes($size, $precision = 2) {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');

        for ($i = 0; $size > 1024 && $i < count($units) - 1; $i++) {
            $size /= 1024;
        }

        return round($size, $precision) . ' ' . $units[$i];
    }
}

// 创建插入器实例并启动
$inserter = new ProductViewInserterWithFileId();

echo "数据库信息:\n";
$dbInfo = $inserter->getDbInfo();
if (isset($dbInfo['error'])) {
    echo "获取数据库信息失败: " . $dbInfo['error'] . "\n";
} else {
    echo "MySQL版本: " . $dbInfo['version'] . "\n";
    echo "表记录数: " . $dbInfo['rows'] . "\n";
    echo "数据大小: " . $dbInfo['data_length'] . "\n";
    echo "索引大小: " . $dbInfo['index_length'] . "\n\n";
}

$inserter->start();

echo "\n脚本执行完毕!\n";
?>



