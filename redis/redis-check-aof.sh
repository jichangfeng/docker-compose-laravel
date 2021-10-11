#!/bin/bash
redis-check-aof /data/appendonly.aof
if [ $? != 0 ];
then
    echo "there are some errors in aof file, the aof file will be backup and fixed."
    cp /data/appendonly.aof /data/appendonly_$(date +'%Y%m%d%H%M%S').aof.bak
    echo "fixing corrupted file start."
    echo y | /usr/local/bin/redis-check-aof --fix /data/appendonly.aof
    if [ $? != 0 ];
	then
    	echo "fix aof file failed. in order to start redis normally, remove corrupted aof file temporarily."
        rm -f "/data/appendonly.aof"
	fi
    exit 0
fi
exit 0
