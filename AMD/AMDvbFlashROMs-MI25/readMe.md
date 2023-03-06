
There are two main prospects to use MI25 with better performance:  

1- Heating:  
Depending on the type of the BIOS, the heating of MI25 would be a problem. The unit comes with passive cooling attached on the graphics processor and has a GPU fan connection at the end of the GPU. Depending on the BIOS, the function of the fan might change. In other words, in one of the BIOS (id: X), GPU will not show any indication of the fan on `rocm-smi` and another one (id: Y), GPU will show that indication. In both cases `rocm-smi --setfan LEVEL` does not work.  
For now, we connected multiple fans without modifying the graphics card's mechanical structure while using a fan shrouds from here{Add ebay link} with appropriate connectors, cables, and fans. In addition, we present in this repository [a Python solution](https://github.com/bankh/GPU_Compute/tree/main/amdgpu-pyfancontrol) for cooling GPU based on the PWM and GPUs temperature curve.

{ADD IMAGE HERE}

2- Upgrading BIOS:  
We upgraded and tested our MI25 with different BIOS rom(see the table below). We utilize a Linux computer with AMDVBFlash by using following commands. Among different references, we found [another github account](https://github.com/stylesuxx/amdvbflash) useful for downloading the flash tool. In the case of the deletion of AMDvbFlash from the link, we will provide the flashtool with a private link by request.
```
{Add how to save existing BIOS from the card} # Read remark 
{Add the commands to upload the target BIOS} 
```
__Remark:__ Please save existing BIOS in your GPU first before flashing the new BIOS

Our intention by using MI25 is taking advantage of its graphics architecture which is similar to one of the well known graphics cards. Once you completed this update you can use the display port (mini HDMI) of MI25 that is caged inside the chassis bracket. Below are the IDs of the ROM files with their prospective links and our test results:

{Add the table}  
[AMD Radeon RX Vega 64](https://www.techpowerup.com/gpu-specs/radeon-rx-vega-64.c2871) - [BIOS 220W](https://www.techpowerup.com/vgabios/197023/amd-rxvegafe-16384-170628](https://www.techpowerup.com/vgabios/196039/amd-rxvega64-16384-170616-1))  
[AMD Radeon RX Vega 64](https://www.techpowerup.com/gpu-specs/radeon-rx-vega-64.c2871) - [FE BIOS 264W](https://www.techpowerup.com/vgabios/197023/amd-rxvegafe-16384-170628)  
[AMD Radeon Pro WX 9100](https://www.techpowerup.com/gpu-specs/radeon-pro-wx-9100.c2989) - [BIOS](https://www.techpowerup.com/vgabios/218718/218718)  
[AMD Instinct MI25](https://www.techpowerup.com/gpu-specs/radeon-instinct-mi25.c2983) - [MI2 BIOS](https://www.techpowerup.com/vgabios/245174/245174)  
[AMD Instinct MI25](https://www.techpowerup.com/gpu-specs/radeon-instinct-mi25.c2983) - [MI25 BIOS default]()  

- Applications (Use Cases)
There are some [references](https://forum.level1techs.com/t/mi25-stable-diffusions-100-hidden-beast/194172/19) that we found as an application of one of the popular generative AI on MI25 by upgrading its BIOS.