FROM ubuntu:18.04

MAINTAINER lyingbo <lyingbo@aliyun.com>

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y ssh openjdk-8-jdk wget

# install hadoop 3.2.0 
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz && \
    tar -xzvf hadoop-3.2.0.tar.gz && \
    mv hadoop-3.2.0 /usr/local/ && \
    rm hadoop-3.2.0.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_HOME=/usr/local/hadoop-3.2.0 
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin 

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p $HADOOP_HOME/namenode && \ 
    mkdir -p $HADOOP_HOME/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/yarn-env.sh $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/workers $HADOOP_HOME/etc/hadoop/workers && \
    mv /tmp/start-dfs.sh $HADOOP_HOME/sbin/start-dfs.sh && \
    mv /tmp/start-yarn.sh $HADOOP_HOME/sbin/start-yarn.sh && \
    mv /tmp/stop-dfs.sh $HADOOP_HOME/sbin/stop-dfs.sh && \
    mv /tmp/stop-yarn.sh $HADOOP_HOME/sbin/stop-yarn.sh && \
    mv /tmp/run-wordcount.sh $HADOOP_HOME/sbin/run-wordcount.sh

# format namenode
RUN $HADOOP_HOME/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]

