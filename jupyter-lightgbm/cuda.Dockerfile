# Use the respective Makefile to pass the appropriate BASE_IMG and build the image correctly
ARG BASE_IMG=<jupyter>
FROM $BASE_IMG

USER root

# needed for LIBNVINFER
ARG OLD_CUDA_VERSION=11.1
# args - software versions
ARG CUDA_VERSION=11.2
ARG CUDA_COMPAT_VERSION=460.73.01-1
ARG CUDA_CUDART_VERSION=11.2.152-1
ARG CUDNN_VERSION=8.1.0.77-1
ARG LIBNVINFER_VERSION=7.2.3-1

# we need bash's env var character substitution
SHELL ["/bin/bash", "-c"]

# install - cuda
# for `cuda-compat-*`: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN curl -sL "https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub" | apt-key add - \
 && echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" > /etc/apt/sources.list.d/cuda.list \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    cuda-compat-${CUDA_VERSION/./-}=${CUDA_COMPAT_VERSION} \
    cuda-cudart-${CUDA_VERSION/./-}=${CUDA_CUDART_VERSION} \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/local/cuda-${CUDA_VERSION} /usr/local/cuda

# envs - cuda
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=${CUDA_VERSION}"

# install - other nvidia stuff
RUN curl -sL "https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub" | apt-key add - \
 && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
 && echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    cm-super \
    cuda-command-line-tools-${CUDA_VERSION/./-} \
    cuda-nvrtc-${CUDA_VERSION/./-} \
    libcublas-${CUDA_VERSION/./-} \
    libcudnn8=${CUDNN_VERSION}+cuda${CUDA_VERSION} \
    libcufft-${CUDA_VERSION/./-} \
    libcurand-${CUDA_VERSION/./-} \
    libcusolver-${CUDA_VERSION/./-} \
    libcusparse-${CUDA_VERSION/./-} \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libnvinfer7=${LIBNVINFER_VERSION}+cuda${OLD_CUDA_VERSION} \
    libnvinfer-plugin7=${LIBNVINFER_VERSION}+cuda${OLD_CUDA_VERSION} \
    libzmq3-dev \
    pkg-config \
    # can't be used until NVIDIA updates (requires python < 3.7)
    # python3-libnvinfer=${LIBNVINFER_VERSION}+cuda${CUDA_VERSION} \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

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
