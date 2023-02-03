# GPU_Compute
Here, notes and tools will be added for GPU Computation. The overall write-up would take some time. As a start of this repository, 
the focus will be more on AMD GPUs and its platforms (e.g., ROCm).

## Hardware
### AMD-based GPUs


### NVidia-based GPUs
TBA

## Software
One of the major challenges in the software arena is the incompatibility between different versions of platforms, drivers, and libraries. This results in significant changes in existing architecture (programs built using these libraries) when transitioning to a new version of the platform (such as ROCm or CUDA). ROCm, for instance, has comparatively limited support and appears more unstable than the CUDA structure of NVIDIA. For example, AMD GPU support is shorter compared to the support provided by NVIDIA. However, there could be various reasons for this, such as a shortage of personnel to handle the programming workload or frequent drastic changes in products (such as gfx8xx, gfx9xx, gfx10xx, RNA, etc.).

### ROCm

#### Installation Process
##### Docker Images
The current process of installing Docker is relatively straightforward and offers flexibility in overcoming compatibility issues between platforms, drivers, and libraries. Simply install the desired version of the target platform, driver, and libraries. Then use whichever docker image is appropriate for the purpose without changing much in the host system. An evaluation is necessary to see the difference between Docker installations as well. For example, we have encountered a problem with ROCm 3.7 installations, which experience computational issues with gfx803-based GPUs (such as the RX580). There are various comments and potential solutions available online related to this and similar issues.

##### Standard Installation
AMD has undergone changes to its documentation system without properly maintaining the previous libraries. For instance, ROCm documentation with some links can be found at [GitHub](https://github.com/RadeonOpenCompute/ROCm/), while another one here, at yet another here. This repetition in the documentation creates confusion and wastes time for users. To remain competitive in the market, AMD needs to take concrete steps to streamline its documentation and support.

Here, we need to refer some of the good examples of fixing the issues for installation:
- xuhuisheng/rocm-build ([repository](https://github.com/xuhuisheng/rocm-build))
- rictorp/rocm.md ([gist link](https://gist.github.com/rigtorp/d9483af100fb77cee57e4c9fa3c74245))
-

## Test System
### Hardware
**CPU:** AMD Ryzen ThreadRipper Pro 3955X (16 Cores - 32 VCPUs)  
**GPU:** Multiple RX580 (8 Gb)  
**RAM:** 256 Gb 3200Mhz  
**Motherboard:** Asus WX WRX80E-SAGE  

__Note:__ The bios (1003) of Asus WX WRX80E-SAGE board was problematic during the first run with multiple GPUs. It require to downgrade the bios to 0701 with a specific way (e.g., [BIOS Flashback](https://www.youtube.com/watch?v=FPyElZcsW6o)) and switch off the on-board graphics output (by default on). 

### Software
**OS:** Linux 20.04.5 LTS (focal)  
**Kernel:** 5.15.0.58-generic  
**Python:** 3.8.10

#### ROCm

##### Benchmarks
It is crucial to evaluate the hardware and software using a standardized architecture. The following results showcase the performance of hardware from two widely recognized frameworks, along with some of their benchmark results obtained from their respective Github repositories.

###### Pytorch


###### Tensorflow
