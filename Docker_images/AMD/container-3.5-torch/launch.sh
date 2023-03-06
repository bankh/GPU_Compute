#!/bin/bash

# Run a Docker container with the following options:
#  -it: Runs the container in interactive mode with a tty.
#  --device=/dev/kfd and --device=/dev/dri: Passes the KFD and DRI devices to the container for GPU support.
#  --security-opt seccomp=unconfined: Disables the default seccomp security profile for the container.
#  --group-add $(getent group render | cut -d':' -f 3): Adds the host's 'render' group to the container to allow access to the GPU.
#  -v /mnt/data_drive:/mnt/data_drive: Mounts the host's '/mnt/data_drive' to the same location in the container.
#  rocm351pytorch: The Docker image to run in the container.

docker run -it --device=/dev/kfd \
	       --device=/dev/dri \
               --security-opt seccomp=unconfined \
	       --group-add $(getent group render | cut -d':' -f 3) \
               -v /mnt/data_drive:/mnt/data_drive \
	       rocm351pytorch

# ToDo: Add Jupyter notebook port for remote connection.
