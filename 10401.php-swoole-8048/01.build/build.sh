#!/bin/bash
# author: xiaonian #
# 构建 docker 镜像2022 #
docker pull centos:centos7.9.2009
docker build -t="php-swoole-8048:2.0.0" .