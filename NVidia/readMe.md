#### Power Connector
Please remark that the connection of NVidia P40 is different than AMD GPUs. NVidia P40/41 GPU has a CPU type of power connector which requires a specific connector to convert PCIe to CPU as indicated in its manual (see p.8 of the [Product Brief](https://images.nvidia.com/content/pdf/tesla/Tesla-P40-Product-Brief.pdf)).
You can find different types of power connectors including NVidia Tesla P40 as shown by CPU Power connections.  

![P40 pinout diagram](https://github.com/bankh/GPU_Compute/assets/9688867/a9288cf3-94ab-46ea-86e6-c8a713a5d09e)

One needs an adapter from a PCIe power source (e.g., server power supply or anything equivalent) for CPU power conversion.  

![P40 Connector](https://github.com/bankh/GPU_Compute/assets/9688867/00363c42-1e09-4557-98ee-d6c44ddc3f79)  

