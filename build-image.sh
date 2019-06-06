#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t lyingbo/hadoop:3.2.0 . 

echo ""
