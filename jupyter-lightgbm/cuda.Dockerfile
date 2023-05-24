# Use the respective Makefile to pass the appropriate BASE_IMG and build the image correctly
ARG BASE_IMG=<jupyter>
FROM $BASE_IMG

USER root

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    cmake build-essential nvidia-opencl-dev libboost-dev libboost-system-dev libboost-filesystem-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# lightGBM
RUN git clone -b v3.3.5 --single-branch --recursive https://github.com/microsoft/LightGBM.git /tmp/LightGBM
RUN cd /tmp/LightGBM \
  && mkdir build \
  && cd build \
  # && cmake -DUSE_CUDA=1 .. \
  && cmake -DUSE_GPU=1 .. \
  && make -j4 \
  && cd ../python-package \
  && python setup.py install 
RUN rm -rf /tmp/LightGBM

USER $NB_UID
