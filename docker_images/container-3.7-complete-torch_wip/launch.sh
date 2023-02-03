#!/bin/bash

sudo docker run -it --rm \
--user $UID \
--name rocm-37-pytorch \
--network host \
--mount type=bind,source=/dev/sdb,target=/mnt/data_drive
--device /dev/dri:/dev/dri \
--device /dev/kfd:/dev/kfd \
-v $PWD:/mnt \
rocm-37-pytorch
