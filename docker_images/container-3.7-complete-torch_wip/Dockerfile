FROM rocm/rocm-terminal:3.7
RUN groupadd -g 109 render
RUN useradd -g render -u 1000 ubuntu
RUN git clone https://github.com/xuhuisheng/rocSPARSE && cd rocSPARSE && bash install.sh -di

