#!/bin/bash

# N is the node number of hadoop cluster
N=$1

if [ $# = 0 ]
then
    echo "Please specify the node number of hadoop cluster!"
    exit 1
fi

# change workers file
echo "hadoop-master" >> config/workers

i=1
while [ $i -lt $N ]
do
    echo "hadoop-slave$i" >> config/workers
    ((i++))
done 

echo ""

echo -e "\nbuild docker hadoop image\n"

# rebuild lyingbo/hadoop image
sudo docker build -t lyingbo/hadoop:3.2.0 . 

echo ""
