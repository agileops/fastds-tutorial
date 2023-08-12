
# docker-pyspark-custom

This Docker project provides a standalone and feature-rich Spark environment for ML development.

## Quickstart

When setting up your machine, ensure you have the correct permissions for your SSH private key.
```
chmod 0400 <Key_name>
```

**Note**: This step isn't necessary on Windows as it emulates POSIX file permissions.

### Testing Hadoop:

```
# First, fetch the dataset:
./prepare.sh

# Download the Docker image. Ensure you are using the latest version.
docker pull agileops/fastds-tutorial:latest

# Start YARN. Remember, $PWD denotes the current path. Load the desired folder for processing, such as $PWD/dataset for this project.
docker run --rm -d -p8888:8888 -p9000:9000 -p 8088:8088 -v $PWD/dataset:/work-dir/data -ti agileops/fastds-tutorial bootstrap.sh

# List all active Docker containers and identify the container ID of the most recent one.
docker ps

# Access your Docker container.
docker exec -ti <docker_container_id> bash

# Before uploading the dataset to HBase, create the parent directory.
hadoop fs -mkdir -p hdfs://localhost:9000/user/root

# Populate HDFS using local data. For additional commands:
hadoop fs -copyFromLocal data/ hdfs://localhost:9000/user/root/data

# Initiate a map/reduce job.
yarn jar $HADOOP_HOME/hadoop-streaming.jar -input data/tpsgc-pwgsc_co-ch_tous-all.csv -output out -mapper /bin/cat -reducer /bin/wc

# Display files in the output directory.
hadoop fs -ls hdfs://localhost:9000/user/root/out

# Display results:
#1) Computation reference using the command line:
wc data/tpsgc-pwgsc_co-ch_tous-all.csv
# 361318 22527194 285375701
#2) Same computation using MapReduce (typically for large files):
hadoop fs -cat out/part-00000
# 361318 22527194 285375701
```

### Testing Spark + Jupyter:

```
# First, fetch the dataset:
./prepare.sh

# Download the Docker image. Ensure you are using the latest version.
docker pull agileops/fastds-tutorial:latest

# Start YARN. Remember, $PWD denotes the current path. Load the desired folder for processing, such as $PWD/dataset for this project.
docker run --rm -d -p8888:8888 -p9000:9000 -p 8088:8088 -v $PWD/dataset:/work-dir/data -ti agileops/fastds-tutorial bootstrap_dataUpload.sh

# List all active Docker containers and identify the container ID of the most recent one.
docker ps

# 20 minutes after executing "docker run", retrieve the Jupyter URL from the logs:
docker logs -f

# Copy the provided URL and paste it into your browser. If you started this image on a remote server, replace "localhost" with your server's IP or domain name.

# Example:
# From the log, you might get a URL like:
# http://localhost:8888/?token=7aa1a049fc513d143b3d607447482ad58300941d3dee8cad

# For remote access, you should use:
# http://<ip_or_domain_name>:8888/?token=7aa1a049fc513d143b3d607447482ad58300941d3dee8cad
```

**Note**: For compatibility, accessibility, and simplicity against hardware and environmental requirements, both TensorFlow and PyTorch are configured without AVX and CUDA support.

## Suggested Datasets

To download these datasets, use the following command after cloning this repository:

```
./prepare.sh
```

- **Canada - Contracts Granted from 2009-Present (270 MB)** 
  [Link](https://ouvert.canada.ca/data/fr/dataset/53753f06-8b28-42d7-89f7-04cd014323b0)

- **Montréal - Bike Path Counting** 
  [Link](http://donnees.ville.montreal.qc.ca/dataset/velos-comptage)
