#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run --privileged \
		-itd \
                --net=hadoop-3.2.2 \
                -p 50070:50070 \
                -p 8088:8088 \
		-p 9870:9870 \
                --name hadoop-master \
                --hostname hadoop-master \
                chuanchiu/hadoop-3.2.2:latest &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run --privileged \
			-itd \
	                --net=hadoop-3.2.2 \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                chuanchiu/hadoop-3.2.2:latest &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
