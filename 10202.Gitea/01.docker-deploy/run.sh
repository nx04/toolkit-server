#!/bin/bash
useradd xiaonian
groupadd softgroup
gpasswd -a xiaonian softgroup
docker-compose up -d