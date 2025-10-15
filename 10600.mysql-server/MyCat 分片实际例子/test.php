<?php

$pdo = new PDO('mysql:host=192.168.109.129:58066;dbname=mycat_testdb', 'root', '123456');

$idStart=100000001;
for ($i = 0; $i < 1000000; $i++) {
    $idStart++;

    $sql = "INSERT INTO t_user (id, name) VALUES (:value1, :value2)";
    $stmt = $pdo->prepare($sql);

    // 绑定参数并执行
    $stmt->bindParam(':value1', $value1);
    $stmt->bindParam(':value2', $value2);

    $value1 = $idStart;
    $value2 = "测试_$idStart";
    $stmt->execute();

    echo $idStart.PHP_EOL;
}
