#!/bin/bash

sudo docker build --build-arg USERNAME=$USER -t rocm-37-pytorch .
