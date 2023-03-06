import os
import time

# Define the path to the PWM interface
pwm_path = "/sys/class/drm/card1/device/hwmon/hwmon3/pwm1"
pwm_enable = "/sys/class/drm/card1/device/hwmon/hwmon3/pwm1_enable"

# Define the temperature thresholds and corresponding PWM values
temp_thresholds = [20, 50, 70]  # in degrees Celsius
pwm_values = [0, 128, 255]      # as a percentage of full speed

# Define the update interval and the minimum and maximum PWM values
update_interval = 2  # in seconds
min_pwm = 20
max_pwm = 255

# Define the function to get the current GPU temperature
def get_temperature():
    temp_file = "/sys/class/drm/card1/device/hwmon/hwmon3/temp1_input"
    if os.path.exists(temp_file):
        with open(temp_file, "r") as f:
            temp_str = f.readline().strip()
            temp = int(temp_str) / 1000.0  # convert to degrees Celsius
            return temp
    else:
        print("Temperature file does not exist.")
        return None

# Define the function to calculate the PWM value based on the temperature
def get_pwm_value(temp):
    if temp < temp_thresholds[0]:
        return min_pwm
    elif temp >= temp_thresholds[-1]:
        return max_pwm
    else:
        for i in range(len(temp_thresholds) - 1):
            if temp >= temp_thresholds[i] and temp < temp_thresholds[i+1]:
                pwm = int(pwm_values[i] + (pwm_values[i+1] - pwm_values[i]) \
                       * (temp - temp_thresholds[i]) / (temp_thresholds[i+1] - temp_thresholds[i]))
                return min(max(pwm, min_pwm), max_pwm)

# Define the main loop to update the fan speed
while True:
    temp = get_temperature()
    pwm = get_pwm_value(temp)
    os.system("echo {}".format(pwm))
    os.system("sudo echo 1 > {}".format(pwm_enable))
    os.system("sudo echo {} > {}".format(pwm, pwm_path))
    time.sleep(update_interval)
