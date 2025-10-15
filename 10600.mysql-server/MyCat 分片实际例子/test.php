<?php

$pdo = new PDO('mysql:host=192.168.109.129:58066;dbname=mycat_testdb', 'root', '123456');

// 准备SQL语句
$stmt = $pdo->prepare('INSERT INTO t_user (id, name) VALUES (:value1, :value2)');

// 准备数据
$data = [];
$idStart=100000001;
for ($i = 0; $i < 1000000; $i++) {
    $idStart++;
    $data[] = [
        ':value1' =>$idStart,
        ':value2' => "测试_$idStart"
    ];
}

// 分批执行插入
$chunkSize = 1000; // 每次插入1000条记录
$count = count($data);
for ($i = 0; $i < $count; $i += $chunkSize) {
    $chunk = array_slice($data, $i, $chunkSize);
    $stmt->execute($chunk);
}
