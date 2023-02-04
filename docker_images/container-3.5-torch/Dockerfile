FROM rocm/rocm-terminal:3.5.1

USER root
RUN echo '' | sudo tee /etc/apt/sources.list.d/rocm.list
RUN apt update -y
#RUN apt install -y software-properties-common
#RUN add-apt-repository -y ppa:deadsnakes/ppa
#RUN apt update -y
RUN apt install -y wget python3.8 python3-pip
RUN echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/debian ubuntu main' | \
    sudo tee /etc/apt/sources.list.d/rocm.list
RUN wget -q -O - https://repo.radeon.com/rocm/rocm.gpg.key | sudo apt-key add -
#RUN apt-get install tini
#RUN apt install -y hipblas hipsparse rocsparse rocrand rocthrust rocsolver rocfft hipcub rocprim rccl
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt update -y && apt install -y liblmdb-dev libopencv-highgui-dev libopencv-contrib-dev libopenblas-dev
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm41/rocblas_2.36.0-93c82939_amd64.deb &&\ 
    dpkg -i rocblas_2.36.0-93c82939_amd64.deb &&\
    rm rocblas_2.36.0-93c82939_amd64.deb 
RUN pip3 install protobuf==3.19.0
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm41/torch-1.8.0a0+56b43f4-cp38-cp38-linux_x86_64.whl
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm41/torchvision-0.9.0a0+8fb5838-cp38-cp38-linux_x86_64.whl
RUN python3.8 -m pip install cython numpy==1.20.0 pillow==7.0.0
RUN python3.8 -m pip install torch-1.8.0a0+56b43f4-cp38-cp38-linux_x86_64.whl  torchvision-0.9.0a0+8fb5838-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.8.0a0+56b43f4-cp38-cp38-linux_x86_64.whl torchvision-0.9.0a0+8fb5838-cp38-cp38-linux_x86_64.whl
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
#ENV TINI_VERSION v0.6.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
#RUN chmod +x /usr/bin/tini
#ENTRYPOINT ["/usr/bin/tini", "--"]
#CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
