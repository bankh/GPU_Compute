FROM rocm/dev-ubuntu-20.04:4.3-complete

RUN apt update -y
RUN apt install -y wget python3-pip
RUN apt install -y hipblas hipsparse rocsparse rocrand rocthrust rocsolver rocfft hipcub rocprim rccl
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt update -y && apt install -y liblmdb-dev libopencv-highgui-dev libopencv-contrib-dev libopenblas-dev
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm43/rocblas_2.39.0-8328dcce.dirty_amd64.deb &&\
    dpkg -i rocblas_2.39.0-8328dcce.dirty_amd64.deb &&\
    rm rocblas_2.39.0-8328dcce.dirty_amd64.deb
RUN pip3 install protobuf==3.19.0
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm43/torch-1.9.0a0+gitd69c22d-cp38-cp38-linux_x86_64.whl
RUN wget https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm43/torchvision-0.10.0a0+300a8a4-cp38-cp38-linux_x86_64.whl
RUN python3 -m pip install torch-1.9.0a0+gitd69c22d-cp38-cp38-linux_x86_64.whl torchvision-0.10.0a0+300a8a4-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.9.0a0+gitd69c22d-cp38-cp38-linux_x86_64.whl torchvision-0.10.0a0+300a8a4-cp38-cp38-linux_x86_64.whl
