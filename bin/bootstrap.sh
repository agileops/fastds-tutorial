#!/bin/bash

# print commands to know where we here
set -x

# Generate host keys
ssh-keygen -A -t rsa
# Generate user keys
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# cat <<EOF >>~/.ssh/config
cat <<EOF >>/etc/ssh/ssh_config
host *
     StrictHostKeyChecking no
     UserKnownHostsFile=/dev/null
EOF

/usr/sbin/sshd -e -D & \
    # Format a new distributed filesystem:
    hdfs namenode -format && \
    #Start the HDFS with the following command, run on the designated NameNode.\
    ${HADOOP_HOME}/sbin/start-dfs.sh && \
    # Start Map-Reduce cluster with the following command, run on the designated JobTracker:
    ${HADOOP_HOME}/sbin/start-yarn.sh && \
    # Before uploading our dataset to hbase, create parent directory
    hdfs dfs -mkdir -p hdfs://localhost:9000/user/root && \
    # Before uploading our dataset to hbase, create parent directory
    hdfs dfs -copyFromLocal data/ hdfs://localhost:9000/user/root/data && \
    # start jupiter notebook
    jupyter notebook --no-browser --ip='*' --port=8888
    # pyspark --master=yarn --deploy-mode=client

# jps
# # Initiated by start-dfs.sh
# 5848 Jps
# 5795 SecondaryNameNode
# 5375 NameNode
# 5567 DataNode
# # Initiated by start-yarn.sh
# 5915 ResourceManager
# 6101 NodeManager
