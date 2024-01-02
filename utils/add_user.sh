#!/bin/bash
# Reference: https://github.com/tinygrad/tinybox/blob/master/new_user.sh
# Description: Script to add a new user and modify group memberships
# Usage: ./add_user.sh <username>

# Add new user with the username provided as the first argument
adduser $1
# Add the new user to the sudo group for admin privileges
usermod -a -G sudo $1
# Add the new user to the render group, typically for GPU access
usermod -a -G render $1
# Add the new user to the video group, usually for video hardware access
usermod -a -G video $1
# Switch to the new user's account
su $1
