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

# xgboost
RUN git clone -b v1.6.2 --single-branch --recursive https://github.com/dmlc/xgboost.git /tmp/xgboost
RUN cd /tmp/xgboost \
  && mkdir build \
  && cd build \
  && cmake .. -DUSE_CUDA=ON \
  && make -j4 \
  && cd ../python-package \
  && python setup.py install
#RUN echo "export PYTHONPATH=$PYTHONPATH:$XGBOOST_ROOT/python-package" >> /home/namu/.bashrc
RUN rm -rf /tmp/xgboost

USER $NB_UID
