# Notes and Tools for GPU Computation

## 📝 Table of Contents

- [1. Hardware](#1-hardware)
  - [1.1 AMD-based GPUs](#11-amd-based-gpus)
  - [1.2 NVIDIA-based GPUs](#12-nvidia-based-gpus)  
- [2. Software](#2-software)
  - [2.1 ROCm](#21-rocm)
    - [2.1.1 Installation Process](#211-installation-process)
      - [2.1.1.1 Docker Images](#2111-docker-images)
      - [2.1.1.2 Standard Installation](#2112-standard-installation)
  - [2.2 CUDA](#22-cuda)  
- [3. Test Systems](#3-test-systems)
  - [3.1 Hardware](#31-hardware)
  - [3.2 Software](#32-software)
    - [3.2.1 ROCm](#321-rocm)
      - [3.2.1.1 Benchmarks](#3211-benchmarks)

This repository will serve as a collection of notes and tools for GPU computation, with an initial emphasis on AMD GPUs (Polaris gfx8xx) and their platforms (e.g. ROCm). In the future, information about Nvidia GPUs will also be added.

![image](https://github.com/bankh/GPU_Compute/assets/9688867/1bdb382c-b51e-4e7b-aead-d0b6175e3462)

## 🔩 1. Hardware  <a name="1-hardware"></a>
The field of GPU computation has been experiencing significant advancements in recent years, driven by the increasing demand for high-performance computing solutions. At the forefront of this progress are two leading companies in the GPU market, Nvidia and AMD. Nvidia GPUs are known for their powerful performance and robust software ecosystem, while AMD GPUs offer a compelling combination of affordability and performance. Whether you are a seasoned veteran or just starting out, this guide will provide you with the information you might find useful to make informed decisions about the hardware you use for your computational needs.  
  
### 1.1 AMD-based GPUs <a name="11-amd-based-gpus"></a>
AMD-based GPUs are a powerful and flexible choice for GPU computing, offering high performance, scalability, and a rich ecosystem of tools and libraries. However, it's important for developers to be mindful of the challenges and limitations that may arise when using these GPUs, and to choose the best platform and tools to suit their specific needs.  
  
__Read More:__  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add active cooling hardware to MI series](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMD_MI25_Hardware)❓  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add temperature controller for an MI series GPU](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMDGPU-pyfancontrol)❓  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to change the firmware of AMD_GPUs](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMDvbFlashROMs-MI25)❓  

### 1.2 NVidia-based GPUs <a name="12-nvidia-based-gpus"></a> 
Nvidia-based GPUs offer a powerful and flexible platform for high-performance computing and graphics rendering, making them an excellent choice for a wide range of applications. Whether you are working in scientific simulations, machine learning, or multimedia content creation, Nvidia-based GPUs can help you get the most out of your computing resources.

## 💾 2. Software <a name="2-software"></a>
One of the major challenges in the software arena is the incompatibility between different versions of platforms, drivers, and libraries. This results in significant changes in existing architecture (programs built using these libraries) when transitioning to a new version of the platform (such as ROCm or CUDA). ROCm, for instance, has comparatively limited support and appears more unstable than the CUDA structure of NVIDIA. For example, AMD GPU support is shorter compared to the support provided by NVIDIA. However, there could be various reasons for this, such as a shortage of personnel to handle the programming workload or frequent drastic changes in products (such as gfx8xx, gfx9xx, gfx10xx, RDNA, etc.).

### 2.1 ROCm <a name="21-rocm"></a>
#### 2.1.1 Installation Process <a name="211-installation-process"></a>  
##### 2.1.1.1 Docker Images <a name="2111-docker-images"></a>
The current process of installing Docker is relatively straightforward and offers flexibility in overcoming compatibility issues between platforms, drivers, and libraries. Simply install the desired version of the target platform, driver, and libraries. Then use whichever docker image is appropriate for the purpose without changing much in the host system. An evaluation is necessary to see the difference between Docker installations as well. 

- [Frameworks Installation](https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3/page/Frameworks_Installation.html)

##### 2.1.1.2 Standard Installation <a name="2112-standard-installation"></a>
AMD has undergone changes to its documentation system without properly maintaining the previous libraries. For instance, ROCm documentation with some links can be found at [GitHub](https://github.com/RadeonOpenCompute/ROCm/), while another one [here](https://rocmdocs.amd.com/), at yet another [here](https://docs.amd.com/). This repetition in the documentation creates confusion and wastes time for users. To remain competitive in the market, AMD needs to take concrete steps to streamline its documentation and support. For example, irrespective of the reference or option, we have encountered a problem with ROCm 3.7 installations, which experience computational issues with gfx803-based GPUs (such as the RX580). Unfortunately, AMD's solution is cutting the support of this particular product. Fortunately, there are various comments and potential solutions available online related to this and similar issues (gfx900 or gfx1000 series).  

Here, we need to refer to some of the good examples of fixing the issues for installation for the case explained above:
- [xuhuisheng/rocm-build](https://github.com/xuhuisheng/rocm-build) and [xuhuisheng/rocm-gfx803](https://github.com/xuhuisheng/rocm-gfx803)  
- rictorp/rocm.md ([gist link](https://gist.github.com/rigtorp/d9483af100fb77cee57e4c9fa3c74245))  
- [AIeater](https://github.com/aieater/rocm_pytorch_informations) by [GPUeater](https://www.gpueater.com/index.html)

Another good example that one can find from YouTube is geohotz' stream on his TinyBox [here](https://www.youtube.com/watch?v=IhkXxFJ_qeI). 

A reference of the GPU comparisons from GPUeater's webpage (relatively old data),
![GPUeater screenshot by AIeater](https://github.com/bankh/GPU_Compute/blob/main/Media/GPUeater_comparison.png?raw=true)

### 2.2 CUDA  <a name="22-cuda"></a>
The same issues arise that the AMD ROCM system has with CUDA. Updates and changes in the dependencies, libraries, and hardware make it difficult to develop solutions by using GPU computation for deep learning applications. Therefore, at the enterprise level, there are solutions such as using cloud platforms, Kubernetes, and other DevOps solutions. For researchers or deep learning studies, it becomes a problem to develop solutions due to a lack of support. Therefore, for AMD's ROCM case, we utilize Docker containers to ease these preparations. However, preparing the right structure in a framework would ease the step of compatibility for the general user. With that, we added here a specific open-source framework, [Cresset](https://github.com/cresset-template/cresset), that could be useful CUDA based machine learning efforts while still using familiar Docker as a platform. 

## 🧪 3. Test Systems <a name="3-test-systems"></a>
### 3.1 Hardware <a name="31-hardware"></a>  

[Reference sample systems from Bizon](https://bizon-tech.com/bizon-zx5500.html#1385:11079;1387:9033;1388:9039;1389:9045;1393:11073)  

**a) AMD/ROCM**  
- Custom Build AMD/ROCm:  
&nbsp;&nbsp;**CPU:** [AMD Ryzen ThreadRipper Pro 3955X (16 Cores - 32 VCPUs)](https://www.amd.com/en/products/cpu/amd-ryzen-threadripper-pro-3955wx)  
&nbsp;&nbsp;**GPUs:**  
&nbsp;&nbsp;&nbsp;&nbsp; ~~[AMD Radeon RX580](https://www.techpowerup.com/gpu-specs/radeon-rx-580.c2938) (8GB each)~~ [Not recommended]  
&nbsp;&nbsp;&nbsp;&nbsp;7x [AMD Radeon Instinct MI25 (16GB each)](https://www.techpowerup.com/gpu-specs/radeon-instinct-mi25.c2983)  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add active cooling hardware to MI series](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMD_MI25_Hardware)❓  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add temperature controller for an MI series GPU](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMDGPU-pyfancontrol)❓  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to change the firmware of AMD_GPUs](https://github.com/bankh/GPU_Compute/tree/main/AMD/AMDvbFlashROMs-MI25)❓  
&nbsp;&nbsp;**RAM:** CORSAIR Vengeance LPX 256GB (8 x 32GB) 288-Pin PC RAM DDR4 3600 (PC4 28800)  
&nbsp;&nbsp;**Motherboard:** [Asus WX WRX80E-SAGE](https://dlcdnets.asus.com/pub/ASUS/mb/SocketTRX4/Pro_WS_WRX80E-SAGE_SE_WIFI/E19401_Pro_WS_WRX80E-SAGE_SE_WIFI_UM_V2_WEB.pdf)  

__Note:__ The BIOS (current up-to-date version 1003) of the Asus WX WRX80E-SAGE board was problematic during the first run with multiple GPUs. It requires to downgrade the BIOS to 0701 with a specific way (e.g., [BIOS Flashback](https://www.youtube.com/watch?v=FPyElZcsW6o)). One also needs to switch on the onboard graphics output switch (by [default 'off'](https://www.asus.com/us/support/FAQ/1049293/)). 

![Test hardware rocm-smi htop](https://github.com/bankh/GPU_Compute/blob/main/Media/test_hardware.png?raw=true)

**b) NVidia/CUDA**  
- Custom Build NVidia/Cuda:  
&nbsp;&nbsp;**CPU:** [AMD Epyc 7532 (32 Cores - 64 VCPUs)](https://www.amd.com/en/products/cpu/amd-epyc-7532)  
&nbsp;&nbsp;**GPUs:**  
&nbsp;&nbsp;&nbsp;&nbsp;[4x NVidia P40 (24GB)](https://www.techpowerup.com/gpu-specs/tesla-p40.c2878) (🔌 [**Connector Warning**](https://github.com/bankh/GPU_Compute/tree/main/NVidia))  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add active cooling hardware to NVidia series]()❓  
&nbsp;&nbsp;&nbsp;&nbsp; :exclamation: [How to add temperature controller for an NVidia series GPU]()❓  
&nbsp;&nbsp;**RAM:**  HMAA8GR7AJR4N-XN (Hynix) 256 GB PC4 3200AA DDR4 25600 2RX4 (4x64GB)  
&nbsp;&nbsp;**Motherboard:** [Asrock Rack RomeD8-2T](https://www.asrockrack.com/general/productdetail.asp?Model=ROMED8-2T#Specifications)  
&nbsp;&nbsp;**HDD:** 2x Crucial P3 Plus 4TB PCIe Gen4 3D NAND NVMe M.2 SSD  
  
- [LambdaClouds](https://cloud.lambdalabs.com/instances) System (1xA10)  
**CPU:** Intel Xeon Platinum 8358 CPU @ 2.60 GHz  
**GPU:** 1x NVidia A10 (24 GB vRAM)  
**RAM:** 200 GB  
**HDD:** 1.4 TB

- [RunPod](https://www.runpod.io/) System (A100)  
**CPU:** AMD EPYC 7343  
**GPU:** NVidia A100 (80GB vRAM)  
**RAM:** 1TB  
**HDD:** 109 GB  
**OS/ Framework:** Ubuntu 22.04/ PyTorch 1.13 (various other Pytorch versions are available)  

### 3.2 Software   <a name="32-software"></a>  
### 3.2.1 ROCm  <a name="321-rocm"></a>

**3.2.1.1 Benchmarks**  <a name="3211-benchmarks"></a>  
It is crucial to evaluate the hardware and software using a standardized architecture. The following results showcase the performance of hardware from two widely recognized frameworks, along with some of their benchmark results obtained from their respective Github repositories.

**3.2.1.1.1 Pytorch**  
[Pytorch/examples repository](https://github.com/pytorch/examples) is one of the great references to see the performance of the current hardware and software.  
```
$ git clone https://github.com/pytorch/examples
```
**a - Single GPU Examples**  
__MNIST__  
```
$ cd examples/mnist
$ python3 main.py --no-mps
```
We run the following with the hardware from section 3.1 a (RX-580) and below is the information for the software.    
**OS:** Linux 20.04.5 LTS (focal)  
**Kernel:** 5.15.0.58-generic  
**Python:** 3.8.10  
**Docker:** version 23.0.0, build e92dd87  
MNIST Result (gfx803 - ROCm 4.3 - torch 1.9.0a0+gitd69c22d)
![MNIST result rocm4.3](./Media/mnist_rocm43.png)

**b - Multi GPUs**  
```
$ cd examples/distributed/ddp-tutorial-series
$ python multigpu.py --batch_size 32 10 5
```
AMD Instinct™  and AMD Instinct accelerators, such as AMD Instinct™ using ROCm in a Linux environment.[1]
```
$ cat /proc/cmdline
```
This will return on the AMD custom system as follows:
```
BOOT_IMAGE=/boot/vmlinuz-5.15.0-91-generic ro quiet splash pcie_aspm=off iommu=pt amd_iommu=on pci=nommconf vt.handoff=7
```
Here `pcie_aspm=off` `iommu=pt` `amd_iommu=on` and `pci=nommconf` are the settings that are required to have according to [1]. To do so

  - Backup current GRUB configuration,
```
$ sudo cp /etc/default/grub /etc/default/grub.bak
```
  Modify the line that starts with GRUB_CMDLINE_LINUX_DEFAULT to match the needed parameters.  

  - Edit GRUB configuration,
```
$ sudo nano /etc/default/grub
```
  - Update GRUB Configuration and reboot the system,
```
$ sudo update-grub
$ sudo reboot
```
❗ **Note:** In the current BIOS of Asus WRX80, we disabled SVM and enabled IOMMU as suggested. We also reduced PCIx Latency from 64 bits to 32 bits in the BIOS config of the motherboard.  
- [Getting Started with Distributed Data Parallel](https://pytorch.org/tutorials/intermediate/ddp_tutorial.html)
- [SINGLE-MACHINE MODEL PARALLEL BEST PRACTICES](https://pytorch.org/tutorials/intermediate/model_parallel_tutorial.html)
- [PCIe X16 vs X8 with 4 x Titan V GPUs for Machine Learning](https://www.pugetsystems.com/labs/hpc/PCIe-X16-vs-X8-with-4-x-Titan-V-GPUs-for-Machine-Learning-1167/)❗ 

❗ **Note:** We have more samples of single GPU training benchmarks for each system in `/CustomSystem/` folders. You can check the log files for [Instinct MI25](https://github.com/bankh/GPU_Compute/tree/main/AMD/CustomSystem) and [Tesla P40](https://github.com/bankh/GPU_Compute/tree/main/NVidia/CustomSystem). ❗

**3.2.1.1.2 Tensorflow**  
A good reference for performance comparison can be found [here](https://github.com/ROCmSoftwarePlatform/tensorflow-upstream/issues/173).  

**References**  
[1] [IOMMU Advisory for Multi-GPU Environments](https://community.amd.com/t5/knowledge-base/iommu-advisory-for-multi-gpu-environments/ta-p/477468)  
[2] [Parallel training with 4 cards 4090 cannot be performed on AMD 5975WX， stuck at the beginning](https://forums.developer.nvidia.com/t/parallel-training-with-4-cards-4090-cannot-be-performed-on-amd-5975wx-stuck-at-the-beginning/237813/3),  
[3] [Multi-GPU Peer to Peer access failing on Tesla K80](https://forums.developer.nvidia.com/t/multi-gpu-peer-to-peer-access-failing-on-tesla-k80/39748/12)  
[4] [Bandyopadhyay, Avimanyu. Hands-On GPU Computing with Python: Explore the capabilities of GPUs for solving high-performance computational problems. Packt Publishing Ltd, 2019.](https://github.com/PacktPublishing/Hands-On-GPU-Computing-with-Python)-[Videos](https://www.youtube.com/playlist?list=PLeLcvrwLe184M3PJ5ricnWuODW2B47tGT)  
[5] Yin, Junqi, et al. "Comparative evaluation of deep learning workloads for leadership-class systems." BenchCouncil Transactions on Benchmarks, Standards, and Evaluations 1.1 (2021): 100005.  


**Disclaimer:**
We make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability or completeness of any information on this repository. We will not be liable for any errors or omissions in this information nor for the availability of this information. We will not be liable for any losses, injuries, or damages from the display or use of this information. Your use of this information is at your own risk.
