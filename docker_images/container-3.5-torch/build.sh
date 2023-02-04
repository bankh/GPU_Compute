#!/bin/bash

# Build a Docker image with the following options:
#  --build-arg USERNAME=$USER: Sets the build argument 'USERNAME' to the current user.
#  -t rocm351pytorch: Tags the image with 'rocm351pytorch'.
#  .: Specifies the build context to be the current directory.
sudo docker build --build-arg USERNAME=$USER -t rocm351pytorch .
