## Run Hadoop Cluster within Docker Containers


- [点我查看中文版](https://lyingbo.github.io/2019/06/14/%E5%9F%BA%E4%BA%8EDocker%E6%90%AD%E5%BB%BAHadoop%E9%9B%86%E7%BE%A4/)


### A. 3 Nodes Hadoop Cluster

##### 1. pull docker image
```
sudo docker pull lyingbo/hadoop:3.2.0
```

##### 2. clone github repository
```
git clone https://github.com/lyingbo/hadoop-cluster-docker.git
```

##### 3. start container
```
cd hadoop-cluster-docker
sudo ./start-container.sh
```

**output:**
```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:/# 
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container

##### 4. start hadoop
```
start-all.sh
```

**output**
```
Starting namenodes on [hadoop-master]
hadoop-master: Warning: Permanently added 'hadoop-master,172.18.0.2' (ECDSA) to the list of known hosts.
Starting datanodes
hadoop-slave2: Warning: Permanently added 'hadoop-slave2,172.18.0.4' (ECDSA) to the list of known hosts.
hadoop-slave1: Warning: Permanently added 'hadoop-slave1,172.18.0.3' (ECDSA) to the list of known hosts.
Starting secondary namenodes [hadoop-master]
Starting resourcemanager
Starting nodemanagers
```

##### 5. run wordcount
```
run-wordcount.sh
```

**output**
```
input file1.txt:
Hello Docker

input file2.txt:
Hello Hadoop

input file3.txt:
Hello MapReduce

wordcount output:
Docker  1
Hadoop  1
Hello   3
MapReduce       1
```

### B. Arbitrary size Hadoop cluster

##### 1. clone github repository
```
do 2 like section A
```

##### 2. rebuild docker image
```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **workers** file, which pecifies the name of all nodes


##### 3. start container
```
sudo ./start-container.sh 5
```
- use the same parameter as the step 2

##### 4. run hadoop cluster 
```
do 4~5 like section A
```
