#!/bin/sh
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)

# if limit_in_bytes is less than 64G in cgroup
if [ "$limit_in_bytes" -le "68719476736" ]
then
    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
    heap_size=$(expr $limit_in_megabytes \* 4 \/ 5)
	echo "export  JAVA_OPTS=\"-Xmx${heap_size}m\"" >> /etc/profile
    echo "export  JAVA_OPTS=\"-Xmx${heap_size}m\"" >> /root/.bashrc
	export  JAVA_OPTS="-Xmx${heap_size}m"
else
	heap_size=4096
	echo "export  JAVA_OPTS=\"-Xmx${heap_size}m\"" >> /etc/profile
    echo "export  JAVA_OPTS=\"-Xmx${heap_size}m\"" >> /root/.bashrc
	export  JAVA_OPTS="-Xmx${heap_size}m"
fi

source  /etc/profile
source  /root/.bashrc
