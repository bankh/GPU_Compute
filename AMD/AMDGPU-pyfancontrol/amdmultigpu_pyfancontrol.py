import os
import time
import glob

# Define the path to the PWM interface for all cards
# Here, we have multiple cards as AMDGPUs in our system.
pwm_path_template = "/sys/class/drm/card{}/device/hwmon/hwmon{}/pwm1"
pwm_enable_template = "/sys/class/drm/card{}/device/hwmon/hwmon{}/pwm1_enable"
temp_files_template = "/sys/class/drm/card{}/device/hwmon/hwmon{}/*_input"

# Define the temperature thresholds and corresponding PWM values for all cards
temp_thresholds = [30, 50, 70]  # in degrees Celsius
pwm_values = [0, 128, 255]      # as a percentage of full speed

# Define the update interval and the minimum and maximum PWM values
update_interval = 2  # in seconds
min_pwm = 20
max_pwm = 255

# Define the function to get the current GPU temperature for all cards
def get_temperature(i):
    temp_list = []
    for temp_file in glob.glob(temp_files_template.format(i+1, "*")):
        with open(temp_file, "r") as f:
            temp_str = f.readline().strip()
            temp = int(temp_str) / 1000.0  # convert to degrees Celsius
            temp_list.append(temp)
    return temp_list

# Define the function to calculate the PWM value based on the temperature for each card
def get_pwm_value(temp_list, card_idx):
    temp = temp_list[card_idx]
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

# Define the main loop to update the fan speed for all cards
while True:
    for i in range(8):
        temp_list = get_temperature(i)
        for j, temp in enumerate(temp_list):
            hwmon_list = glob.glob(temp_files_template.format(i+1, "*"))
            if not hwmon_list:
                continue
            hwmon = hwmon_list[0]
            pwm = get_pwm_value(temp_list, j)
            hwmon_num = hwmon.split("/")[-2][5:]
            pwm_path = pwm_path_template.format(i+1, hwmon_num)
            pwm_enable = pwm_enable_template.format(i+1, hwmon_num)
            os.system("echo {}".format(pwm))
            os.system("sudo echo 1 > {}".format(pwm_enable))
            os.system("sudo echo {} > {}".format(pwm, pwm_path))
    time.sleep(update_interval)
