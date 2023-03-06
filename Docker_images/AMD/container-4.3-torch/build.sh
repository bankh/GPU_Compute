#!/bin/bash

sudo docker build --build-arg USERNAME=$USER -t rocm43pytorch .
