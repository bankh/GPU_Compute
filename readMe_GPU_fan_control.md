We need to write a script to access the PWM (Pulse Width Modulation) of the GPU. PWM will
allow to change the angular velocity of the fan. PWM is a common technique to control 
the voltage and with that the motor's angular velocity.   

In AMDGPU's implementation, an 8-bit representation (0-255 as decimal) corresponds to
0-100% angular velocity of the fan-under-interest. Here, there is a reminder for the GPU.
The control of the fan is an issue for the GPU where the GPU doesn't have a fan. With that,
the provided method is a solution for MI25 (or other cards without active cooling solution)
--that we have been testing.  

To test the initial control of the card, we can use the following script,   
```
cat /sys/class/drm/card1/device/hwmon/hwmon*/temp1_input
cat /sys/class/drm/card1/device/hwmon/hwmon*/pwm1
```

### Installation of the AMDGPU Fan Control
We can follow the following steps to install amdgpu-fancontrol. We utilize this method
from [another github repository](https://github.com/grmat/amdgpu-fancontrol). 

First clone the repository:  
```
git clone https://github.com/bankh/GPU_Compute.git
```

Please recall that the following steps requires __SUPER USER__(`sudo`) privilege and after
pulling the repository.  
```
# Overwrite old scripts
cp amdgpu-fancontrol /usr/bin

# Configuration file
cp amdgpu-fancontrol.cfg /etc/

# Copy the services to the service folder
cp amdgpu-fancontrol.service /etc/systemd/system

# Copy path file to the service folder
cp amdgpu-fancontrol.path /etc/systemd/system

# Start the service on boot
systemctl restart amdgpu-fancontrol.path
```
