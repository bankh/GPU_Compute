#!/bin/bash
# Reference: https://github.com/tinygrad/tinygrad/blob/master/extra/assembly/rocm/rocm_from_scratch.sh
# From NOTES:
# Built ROCT-Thunk-Interface (hsakmt)
#   hsakmt-roct-dev_5.4.4.99999-local_amd64.deb
#   note: installs to /opt/rocm
# Built ROCm-Device-Libs
#   Works with ROCM_PATH=/home/tiny/build/ROCm-Device-Libs/build/dist
#   rocm-device-libs_1.0.0.99999-local_amd64.deb
# Built ROCm-CompilerSupport (amd_comgr)
#   no deb, sudo make install to /usr/local
# Built ROCR-Runtime
#   hsa-rocr_1.8.0-local_amd64.deb
#   hsa-rocr-dev_1.8.0-local_amd64.deb
# Built ROCm-OpenCL-Runtime
#   rocm-ocl-icd_2.0.0-local_amd64.deb
#   ISSUE: these depend on "comgr"
#   rocm-opencl_2.0.0-local_amd64.deb
#   rocm-opencl-dev_2.0.0-local_amd64.deb
#   Did sudo make install

mkdir -p build/debs
cd build

# ROCT-Thunk-Interface (hsakmt)
if [ ! -f debs/hsakmt-roct-dev_5.5.0.99999-local_amd64.deb ]
then
  mkdir -p ROCT-Thunk-Interface
  cd ROCT-Thunk-Interface
  cmake ../../src/ROCT-Thunk-Interface
  make -j$(nproc) package
  cp hsakmt-roct-dev_5.5.0.99999-local_amd64.deb ../debs
  cd ../
fi

# build custom LLVM
if [ ! -f llvm-project/bin/clang ]
then
  mkdir -p llvm-project
  cd llvm-project
  cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="llvm;clang;lld" -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" ../../src/llvm-project/llvm
  make -j$(nproc)
  cd ..
fi

# use custom LLVM
export PATH="$PWD/llvm-project/bin:$PATH"

# ROCm-Device-Libs
if [ ! -f debs/rocm-device-libs_1.0.0.99999-local_amd64.deb ]
then
  mkdir -p ROCm-Device-Libs
  cd ROCm-Device-Libs
  cmake ../../src/ROCm-Device-Libs
  make -j$(nproc) package
  cp rocm-device-libs_1.0.0.99999-local_amd64.deb ../debs
  cd ../
fi

# ROCR-Runtime
if [ ! -f debs/hsa-rocr_1.8.0-local_amd64.deb ]
then
  mkdir -p ROCR-Runtime
  cd ROCR-Runtime
  cmake ../../src/ROCR-Runtime/src
  make -j$(nproc) package
  cp hsa-rocr_1.8.0-local_amd64.deb ../debs
  cp hsa-rocr-dev_1.8.0-local_amd64.deb ../debs
  cd ../
fi

# ROCm-OpenCL-Runtime (needs ROCclr)
if [ ! -f debs/rocm-opencl_2.0.0-local_amd64.deb ]
then
  mkdir -p ROCm-OpenCL-Runtime
  cd ROCm-OpenCL-Runtime
  cmake ../../src/ROCm-OpenCL-Runtime
  make -j$(nproc) package
  cp rocm-opencl_2.0.0-local_amd64.deb ../debs
  cp rocm-opencl-dev_2.0.0-local_amd64.deb ../debs
  cp rocm-ocl-icd_2.0.0-local_amd64.deb ../debs
fi

# ROCm-CompilerSupport (broken)
#mkdir -p ROCm-CompilerSupport
#cd ROCm-CompilerSupport
#cmake ../../src/ROCm-CompilerSupport/lib/comgr
#make -j$(nproc)"
