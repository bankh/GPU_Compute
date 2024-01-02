#!/bin/bash
# Reference: https://github.com/tinygrad/tinygrad/blob/master/extra/assembly/rocm/rocm_setup.sh
# (Similar to standard documentation i.e., https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-rocm-installation-readme/#option-1)
rm amdgpu-install_5.5.50500-1_all.deb
wget https://repo.radeon.com/amdgpu-install/5.5/ubuntu/$(lsb_release -cs)/amdgpu-install_5.5.50500-1_all.deb
sudo dpkg -i amdgpu-install_5.5.50500-1_all.deb
sudo apt-get update

# kernel driver
sudo apt-get install amdgpu-dkms

# for opencl
sudo apt-get install rocm-opencl-runtime

# for HIP
sudo apt-get install hip-runtime-amd rocm-device-libs hip-dev
