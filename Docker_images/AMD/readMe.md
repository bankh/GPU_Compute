**Suggested Installation steps (AMDGPU gfx803/gfx900):**  
We can present a simple method of installation without a dockerfile and relying on the standard tools from the developers (e.g., Pytorch, Docker, AMD, etc.).  

**1-** Clone PyTorch repository on the host system:  
```
$ cd ~  
$ git clone https://github.com/pytorch/pytorch.git  
$ cd pytorch  
$ git checkout 1.6 # Read the remark below
$ git submodule update --init --recursive
```
__Remark:__ Please make sure that you setup the appropriate version of the Pytorch on this step that you plan to install for the Docker container. Otherwise, especially for the legacy versions (e.g., Pytorch 1.6), the later steps will utilize more recent libraries and the generated Docker image will have issues. Therefore, it is important to use the same version of the Pytorch and changing the version (e.g., `1.6`). 


**2-** Build the PyTorch Docker image (in Python folder that we pulled from GH):  
Below the build sample is __Ubuntu 18.04 Bionic for ROCm3.5 and Python 3.8__ for RX580 (gfx803).  
```
$ cd .circleci/docker
$ ./build.sh pytorch-linux-bionic-rocm3.5-py3.8
```
__Remark:__ This installation will be problematic for MI25(gfx900). The following command would be useful for that GPU:
```
$ cd .circleci/docker
$ ./build.sh pytorch-linux-focal-rocm4.0.1-py3.8
```
This installation has some problems in later stages. There is a known patch of rocm4.0.1 with PyTorch. One can find the details in this [link](https://github.com/pytorch/pytorch/commit/51526332583ceaebdeef697322a9a8b2b20427f3)

This should be complete with a message, "Successfully build."  

**3-** Check the existence of the Docker image on the host system:  
```
$ docker images
```
The command above should return `pytorch-linux-bionic-rocm3.5-py3.8` and we can use the image in the next step.

**4-** Start a Docker container using the generated image (on step #2 - 'pytorch-linux-bionic-rocm3.5-py3.8') the comments below explain the code syntax as well.  
  
```
docker run -it \                          # Run a command in interactive mode with a pseudo-TTY 
--name my_container_name \                # Assign a name for the container for easy identification
--cap-add=SYS_PTRACE \                    # Grant the SYS_PTRACE capability to the container (useful for debugging/tracing)
--security-opt seccomp=unconfined \       # Disable the default seccomp security profile, enabling more syscalls in the container
--device=/dev/kfd \                       # Map the /dev/kfd device to the container (related to AMD ROCm)
--device=/dev/dri \                       # Map the /dev/dri device to the container (related to graphics rendering)
--group-add $(getent group video | cut -d':' -f 3) \ # Add the container to the 'video' group (usually for graphics purposes)
--ipc=host \                              # Share the IPC namespace with the host; useful for inter-process communication between host and container
--shm-size 8G \                           # Set the size of the shared memory segment to 8GB; useful for certain applications like databases or deep learning frameworks
-p 0.0.0.0:6006:6006 \                    # Map the container's port 6006 to the host's port 6006; accessible to any IP address on the host system
-v /mnt/data_drive:/mnt/data_drive \      # Mount the /mnt/data_drive directory from the host to the same path in the container
-v /home/ubuntu:/mnt/ubuntu \             # Mount the /home/ubuntu directory from the host to /mnt/ubuntu in the container
pytorch-linux-bionic-rocm3.5-py3.8        # The Docker image name to use, which in this case appears to be a specific PyTorch image built for Ubuntu Bionic with ROCm3.5 and Python 3.8
```
Enabling GPU and Display and make it accessible from host computer:  
```
docker run -it \                           # Run a command in interactive mode and allocate a pseudo-TTY 
--name my_container_name \                # Set a name for the container to make it easier to reference
--cap-add=SYS_PTRACE \                    # Grant the container the SYS_PTRACE capability (useful for debugging)
--security-opt seccomp=unconfined \       # Disable the seccomp security profile, allowing the container more syscalls
--device=/dev/kfd \                       # Pass through the /dev/kfd device to the container (related to AMD ROCm)
--device=/dev/dri \                       # Pass through the /dev/dri device to the container (related to graphics rendering)
--group-add $(getent group video | cut -d':' -f 3) \ # Add the container to the 'video' group (usually related to graphics)
--ipc=host \                              # Use the host's IPC namespace, which can help in certain use-cases like shared memory segments
-v /mnt/data_drive:/mnt/data_drive \      # Mount the host's /mnt/data_drive directory to the container's /mnt/data_drive directory
-v /home/ubuntu:/mnt/ubuntu \             # Mount the /home/ubuntu directory from the host to /mnt/ubuntu in the container
-p 0.0.0.0:6006:6006 \                    # Publish the container's port 6006 to the host's port 6006, making it accessible externally
-e DISPLAY=$DISPLAY \                     # Pass the DISPLAY environment variable from the host to the container, useful for GUI applications
rocm2.7_ubuntu18.04_py3.6_pytorch         # The Docker image to use
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
# git clone https://github.com/pytorch/pytorch.git  
$ cd pytorch  
# git checkout 1.6 #v1.8.0 for 1.8 check the tags of PyTorch GitHub repo
# git submodule update --init --recursive
```
__Note:__ '#' for super user mode and '$' is for regular user.  
**7-** Install the pytorch on the container that is started on step #4.  
**a.** Determine the architecture (uarch) of the graphics card (GPU):
```
$ rocminfo | grep gfx
```

**b.** Setup the compiler for a specific hardware architecture  
For RX580(gfx803):
```
$ export PYTORCH_ROCM_ARCH=gfx803
```
For MI25(gfx900)  
```
$ export PYTORCH_ROCM_ARCH=gfx900
```

**c.**  Hippify (converting AMD compatible form) the Pytorch files, compile, and install the library.
```
$ sudo chmod -R 777 ./pytorch/
$ python3 tools/amd_build/build_amd.py
$ USE_ROCM=1 MAX_JOBS=$(nproc) python3 setup.py install --user  #Remark to consider to use less core in MAX_JOBS
```

**(Alternative).** Build pytorch using a bash script which hippify and compile PyTorch:  
```
$ ./.jenkins/pytorch/build.sh
```

__Note:__ Please make sure checking the versions of the other libraries (e.g., see [torchvision version table](https://pypi.org/project/torchvision/), [torchtext version table](https://pypi.org/project/torchtext/)) which are critical for the operation of the PyTorch. For example, for torch1.6, the installation of torchtext and torchvision will be:  

```
$ pip install torchvision==0.6.0 --no-deps
$ pip install torchtext==0.7 --no-deps
```

We suggest to install without the dependencies (use `--no-deps` flag). Otherwise, the installation might neglect the version of the torch that you compiled and might try to use the installer manager to override the torch. This will result in an installation that won't be compatible to AMD GPUs.

If you install a compatible version and still experiencing errors you can follow an installation from source on the Docker Container:  

torchvision:
```
$ cd ~
$ git clone https://github.com/pytorch/vision.git
$ cd vision
$ git checkout v0.6.0 # This version is the compatible one with respect to the compiled PyTorch from the example above
$ USE_ROCM=1 MAX_JOBS=$(nproc) USE_OPENCV=1 python3 setup.py install --user
```

torchtext:
```
$ cd ~
$ git clone https://github.com/pytorch/text.git
$ cd text
$ git checkout 0.6.0 # This version (or 0.7.0) is the compatible one with respect to the compiled PyTorch from the example above
$ USE_ROCM=1 MAX_JOBS=$(nproc) USE_OPENCV=1 python3 setup.py install --user
```

torch_geometric [__3__]
```
$ git clone https://github.com/pyg-team/pytorch_geometric
$ git clone --recursive https://github.com/rusty1s/pytorch_sparse
$ git clone https://github.com/rusty1s/pytorch_scatter
$ cd pytorch_sparse
$ git checkout 0.6.7 # check release or the date of the release to find the matching PyTorch version (1.6 this case) https://github.com/rusty1s/pytorch_sparse/releases?page=2
$ pip install . -vvv |& tee ~/build_sparse.log
$ mv ../build_sparse.log ./
$ cd ../pytorch_scatter
$ git checkout 1.4.0
$ pip install . -vvv |& tee ~/build_scatter.log
$ mv ../build_scatter.log ./
$ cd ../pytorch_geometric
$ git checkout 1.6.0
$ pip install . -vvv |& tee ~/build_geometric.log 
$ mv ../build_geometric.log ./
```
__Notes:__  
1- Please make sure the compatibility of the PyTorch version with the corresponding Geometric, Sparse, and Scatter installations.  
2- Alternatively, one can use direct docker image from [rocm/pytorch:latest](https://hub.docker.com/r/rocm/pytorch)

**Reference:**  
[1] [ROCm Deep Learning Guide v5.3](https://hub.docker.com/r/rocm/pytorch)  
[2] [Framework Installation](https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3/page/Frameworks_Installation.html)  <br/>
[3] [Some compatible questions when I use ROCm on AMD GPU](https://github.com/pyg-team/pytorch_geometric/discussions/6370)
