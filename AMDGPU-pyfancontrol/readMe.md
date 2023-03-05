AMD GPUs typically allow for PWM (pulse width modulation) control of the fan speed, which can help to reduce noise and improve the overall performance of the system.

To control the fan speed on an AMD GPU using PWM, you can use a program like AMD Wattman or a third-party tool like MSI Afterburner.

In AMD Wattman, you can navigate to the "Fan Control" section and enable "Advanced Fan Control." This will allow you to set a custom fan curve based on temperature. The fan speed will increase as the temperature of the GPU increases, and decrease as the temperature decreases. You can adjust the fan curve by dragging the points on the graph to your desired settings.

In MSI Afterburner, you can also control the fan speed using PWM. You can click on the "Fan" tab and select "Custom" from the fan speed settings. This will allow you to set a custom fan curve based on temperature, similar to AMD Wattman.

It is important to note that adjusting the fan speed can impact the temperature of the GPU and may affect the stability of the system. It is recommended to monitor the temperature of the GPU and adjust the fan curve accordingly to ensure optimal performance and stability.

In this readMe file, we present a python script to access the PWM (Pulse Width Modulation) of the GPU and adding that as service to run it after restarting the computer. PWM will allow to change the angular velocity of the fan. PWM is a common technique to control the voltage and with that the fan's angular velocity.   

In AMDGPU's implementation, an 8-bit representation (0-255 as decimal) corresponds to 0-100% angular velocity of the fan-under-interest. Here, there is a reminder for the GPU. The control of the fan is an issue for the GPU where the GPU doesn't have a fan. With that, the provided method is a solution for MI25 (or other cards without active cooling solution) --that we have been testing.  

To test the initial control of the card, we can use the following script,   
```
cat /sys/class/drm/card1/device/hwmon/hwmon*/temp1_input
cat /sys/class/drm/card1/device/hwmon/hwmon*/pwm1_enable
cat /sys/class/drm/card1/device/hwmon/hwmon*/pwm1
```
__Note:__ You can use the following command to find the appropriate card for testing with the commands above.
```
sudo find /* -name 'temp1_input'
```

### Setup/ Installation of the AMDGPU Fan Control
We can follow the steps below to install amdgpu-fancontrol. One can utilize alternative methods
from [another github repository](https://github.com/grmat/amdgpu-fancontrol) by using bash scripts instead of Python script. 

**System's Features:**  
OS: Ubuntu 20.04 (Focal) (Check with command `lsb_release -a`)  
Kernel: Linux 5.15.0-67-generic #74~20.04.1-Ubuntu x86_64 x86_64 x86_64 GNU/Linux (Check with command `uname -a`)  
Python version: 3.8 (Check with command 'python --version')  

0- First clone the repository:  
```
git clone https://github.com/bankh/GPU_Compute.git
```
__Note:__ The scripts are in [`./amdgpu_pyfancontrol/`](https://github.com/bankh/GPU_Compute/tree/main/amdgpu-pyfancontrol).

1- Create a new systemd service unit file by running the following command:
```
sudo nano /etc/systemd/system/amdgpu_pyfancontrol.service
```
2- In the editor, add the following lines to define the service unit and save/exit from the editor:
```
[Unit]
Description=My AMD fan control service
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /path/to/myfancontrol.py
Restart=on-abort

[Install]
WantedBy=multi-user.target

```
__Remark:__ Replace "/path/to/myfancontrol.py" with the actual path to your fan control script. In this example, the python file is [amdgpu_pyfancontrol.py](https://github.com/bankh/GPU_Compute/blob/main/amdgpu-pyfancontrol/amdgpu_fancontrol.py).

3- Reload the systemd daemon to pick up the new service unit file by running the following command:
```
sudo systemctl daemon-reload
```

4- Enable the service to start at boot time by running the following command:
```
sudo systemctl enable amdgpu_pyfancontrol.service

```

5- Start the service by running the following command:
```
sudo systemctl start amdgpu_pyfancontrol.service

```

Now, your fan control script should start running as a background service every time the system boots up. You can check the status of the service by running the following command:
```
sudo systemctl status amdgpu_pyfancontrol.service
```


