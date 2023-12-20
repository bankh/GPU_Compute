#### Temperature Control of NVidia (Tesla P40) GPU  
- Unlike AMD, NVidia's GPU access through `/sys/class/drm` is quite limited. One has to use `nvidia-smi` in a specific way to get the temperature data from GPU(s).
```
$ nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
```
**Note:** There are other options to read temperature from GPU (e.g., `lm-sensors`). However, for now, we will stick with NVidia's tool and will test it further.  

- Since the Nvidia P40 doesn't have an onboard fan (or any fan control), we will use our motherboard's fan pins and its controller via IPMI (Intelligent Platform Management Interface) --to be specific `ipmitools` for AsRock Rack RomeD8-2T.  
One can find more details in the reference section **[1]**.
First, install the tool,  
```
$ sudo apt install ipmitool
```
Enable the tool to control the fan manually (16 entries for RomeD8) (0x0 is leaving the FAN1 in auto mode),  
```
$ sudo ipmitool raw 0x3a 0xd8 0x0 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1 0x1
```
Disable manual control and revert to automatic,  
```
$ sudo ipmitool raw 0x3a 0xd8 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
```
100% duty cycle for PWM to the FANS:  
```
$ sudo ipmitool raw 0x3a 0xd6 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
```
50% duty cycle for PWM to the FANS:  
```
$ sudo ipmitool raw 0x3a 0xd6 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32 0x32
```
To see manual fan settings:  
```
$ sudo ipmitool raw 0x3a 0xd7
```
To fetch current duty cycle:  
```
$ sudo ipmitool raw 0x3a 0xda
```
We can also check the all the available data on `ipmitool` by:  
```
$ sudo ipmitool sensor
```
You should see a response similar to the one below in the terminal:  
![image](https://github.com/bankh/GPU_Compute/assets/9688867/3eace444-49f3-4946-b1b1-0561fbb66fa6)

One can find a code sample below to control the fans **[2]**:  
```
#!/bin/bash
# Requirements:
# Coolbits bit 2 to enable fan control.

# Dependencies:
# GNU BC: https://www.gnu.org/software/bc/

sleep_time="5s"

# On close, set fan speed back to automatic mode.
trap 'nvidia-settings -a "GPUFanControlState=0"; exit 0;' SIGINT SIGTERM
# Set fan speed to manual mode.
nvidia-settings -a "GPUFanControlState=1" 1> /dev/null

# Set the fan speed based on GPU temp, in celsius, as the argument.
set_fan_speed() {
    case "${1}" in
        [0-8][0-9])  # 0-89
            fan_speed=$(printf %.0f $(echo "1.62 + e(0.0515*$1)" | bc -l))
            ;;
        *)  # Default
            fan_speed="100"
            ;;
    esac

    nvidia-settings -a "GPUTargetFanSpeed=${fan_speed}" 2>&1 >/dev/null
    echo "Setting Nvidia fan speed: $fan_speed Temp: $1"
}


while true
do
    gputemp=$(nvidia-settings -q GPUCoreTemp | awk -F ":" 'NR==2{print $3}' | sed 's/[^0-9]*//g')

    if [ "$gputemp" != "$oldtemp" ] ; then
        set_fan_speed "$gputemp"
    fi

    oldtemp=$gputemp
    sleep "$sleep_time"
done
```
**REMARK:** It is important to note the **CPU Fan** and leave that control in auto-mode. On my motherboard it is connected to FAN1, so I keep it in auto-mode in the sample above.

#### Power Connector
Please note that the connection of NVidia P40 is different than AMD GPUs. NVidia P40/41 GPU has a CPU type of power connector that requires a specific connector to convert PCIe to CPU as indicated in its manual (see p.8 of the [Product Brief](https://images.nvidia.com/content/pdf/tesla/Tesla-P40-Product-Brief.pdf)).
You can find different types of power connectors including NVidia Tesla P40 as shown by CPU Power connections.  

![P40 pinout diagram](https://github.com/bankh/GPU_Compute/assets/9688867/a9288cf3-94ab-46ea-86e6-c8a713a5d09e)

One needs an adapter from a PCIe power source (e.g., server power supply or anything equivalent) for CPU power conversion.  

![P40 Connector](https://github.com/bankh/GPU_Compute/assets/9688867/00363c42-1e09-4557-98ee-d6c44ddc3f79)  

**References:**  
**[1]** IPMI Hex codes of AsRock Rack RomeD8-2T: https://www.asrockrack.com/support/faq.asp?k=hex  
**[2]** Sample code to control fans via `ipmitool`: https://gist.github.com/patrickjennings/ceabd8e9248d0c44fb3b577b5b513995


