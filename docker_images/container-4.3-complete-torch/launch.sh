#!/bin/bash
docker run -it --device=/dev/kfd \
	       --device=/dev/dri \
               --security-opt seccomp=unconfined \
               --group-add $(getent group render | cut -d':' -f 3) \
               -v /mnt/data_drive:/mnt/data_drive \  # to mount /mnt/data_drive to docker container for accessing data
	       rocm43pytorch

#sudo docker run -it --rm \
#--user $UID \
#--name rocm43pytorch \
#--network host \
#--mount type=bind,source=/dev/sdb,target=/mnt/data_drive\
#--device /dev/dri:/dev/dri \
#--device /dev/kfd:/dev/kfd \
#-v $PWD:/mnt \
#rocm43pytorch
