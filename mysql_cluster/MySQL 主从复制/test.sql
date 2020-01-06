
CREATE database testdb0;
CREATE database testdb1;
CREATE database testdb2;
CREATE database testdb3;
CREATE database testdb4;
CREATE database testdb5;
CREATE database testdb6;
CREATE database testdb7;
CREATE database testdb8;
CREATE database testdb9;
CREATE database testdb10;
CREATE database testdb11;

USE testdb0;
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account`  (
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `account` VARCHAR(40) NOT NULL COMMENT '账号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 ROW_FORMAT = Dynamic;



USE testdb0;
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` DATETIME NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 ROW_FORMAT = Dynamic;

