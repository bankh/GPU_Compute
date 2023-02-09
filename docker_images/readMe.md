## Docker Installation
Here, the presented images are tested under the testing system without an error. The folders with a suffix of '_wip' states a work-in-progress and not suggested to use.  

**Suggested Installation steps:**  
We can present a simple method of installation without a dockerfile and relying on the standard tools from the developers (e.g., Pytorch, Docker, AMD, etc.).  

**1-** Clone PyTorch repository on the host system:  
```
$ cd ~  
$ git clone https://github.com/pytorch/pytorch.git  
$ cd pytorch  
$ git checkout 1.6 # Read the remark below
$ git submodule update --init --recursive
```
__Remark:__ Please make sure that you setup the appropriate version of the Pytorch on this step that you plan to install for the Docker container. Otherwise, especially for the legacy versions (e.g., Pytorch 1.6), the later steps will utilize more recent libraries and the generated Docker image will have issues. Therefore, it is important to use the same version of the Pytorch and changing the version (e.g., `1.6` below) by using the following command:  


**2-** Build the PyTorch Docker image:  
Below the build sample is __Ubuntu 18.04 Bionic for ROCm3.5 and Python 3.8__.  
```
$ cd .circleci/docker
$ ./build.sh pytorch-linux-bionic-rocm3.5-py3.8
```
This should be complete with a message, "Successfully build."  

**3-** Check the existence of the Docker image on the host system:  
```
$ docker images
```
The command above should return `pytorch-linux-bionic-rocm3.5-py3.8` and we can use the image in the next step.

**4-** Start a Docker container using the generated image (on step #2 - 'pytorch-linux-bionic-rocm3.5-py3.8') the comments below explain the code syntax as well.  
**-it**: Starts the container in interactive mode, allowing you to interact with the terminal of the container.  
**--cap-add=SYS_PTRACE**: Adds the capability SYS_PTRACE to the container, which allows processes in the container to trace other processes.  
**--security-opt seccomp=unconfined**: Disables the default seccomp security profile for the container, allowing the container to use system calls that would otherwise be restricted.  
**--device=/dev/kfd** and **--device=/dev/dri**: Adds access to the GPU in the host system to the container, which is necessary for GPU-accelerated computations.  
**--group-add video**: Adds the video group to the container, which is necessary for GPU acceleration.  
**--ipc=host**: Sets the inter-process communication (IPC) namespace of the container to that of the host, allowing the container to share IPC resources with the host.  
**--shm-size 8G**: Sets the size of the shared memory for the container to 8GB.  
**-v /mnt/data_drive:/mnt/data_drive**: Mounts the `/mnt/data_drive` directory from the host system to the same directory within the container, allowing the container to access data on the host system. That is especially useful to share the data or model between different Docker images and the host system.  
**pytorch-linux-bionic-rocm3.5-py3.8**: Specifies the name of the Docker image to run.  

```
$ docker run -it --cap-add=SYS_PTRACE --security-opt \
                 seccomp=unconfined --device=/dev/kfd \
                 --device=/dev/dri --group-add video \
                 --ipc=host --shm-size 8G \
                 -v /mnt/data_drive:/mnt/data_drive \
                 pytorch-linux-bionic-rocm3.5-py3.8
```

**5-** Update the address and key for apt repo with `apt update`
```
$ wget -qO - https://repo.radeon.com/rocm/rocm.gpg.key | sudo apt-key add -
$ echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/3.5/ xenial main' | sudo tee /etc/apt/sources.list.d/rocm.list
$ sudo apt update
```

**6-** Pull the Pytorch to the docker container:
```
$ cd ~  
$ git clone https://github.com/pytorch/pytorch.git  
$ cd pytorch  
$ git checkout 1.6
$ git submodule update --init --recursive
```

**7-** Install the pytorch on the container that is started on step #4.  
**a.** Determine the <uarch> (architecture) of the graphics card (GPU):
```
$ rocminfo | grep gfx
```
**b.** Setup the compiler for a specific hardware architecture (e.g., gfx803 for Polaris cards RX580):
```
$ export PYTORCH_ROCM_ARCH=gfx803
```
**c.** Build pytorch using a bash script which hippify (converting AMD compatible form) and compile PyTorch:  
```
$ ./.jenkins/pytorch/build.sh
```

**(Alternative).** Hippify the Pytorch files, compile, and install the library.
```
$ python3 tools/amd\_build/build\_amd.py
$ USE\_ROCM=1 MAX\_JOBS=4 python3 setup.py install --user
```

__Note:__ Please make sure checking the versions of the other libraries (e.g., see [torchvision version table](https://pypi.org/project/torchvision/), [torchtext version table](https://pypi.org/project/torchtext/)) which are critical for the operation of the PyTorch. For example, for torch1.6, the installation of torchtext and torchvision will be:  

```
$ pip install torchvision==0.7.0 --no-deps
$ pip install torchtext==0.7 --no-deps
```

We suggest to install without the dependencies (use `--no-deps` flag). Otherwise, the installation might neglect the version of the torch that you compiled and might try to use the installer manager to override the torch. This will result in an installation that won't be compatible to AMD GPUs.

**Reference:**  
[1] [ROCm Deep Learning Guide v5.3](https://hub.docker.com/r/rocm/pytorch)  
[2] [Framework Installation](https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3/page/Frameworks_Installation.html)
