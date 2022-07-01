#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build --no-cache -t chuanchiu/hadoop-3.2.2 .

echo ""
