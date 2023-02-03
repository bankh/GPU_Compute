#!/bin/bash
docker run -it --device=/dev/kfd \
	       --device=/dev/dri \
               --security-opt seccomp=unconfined \
               --group-add $(getent group render | cut -d':' -f 3) \
               -v /mnt/data_drive:/mnt/data_drive \  # to mount /mnt/data_drive to docker container for accessing data
	       rocm43pytorch
