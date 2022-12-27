FROM python:3.8

# init
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git

# pkg
RUN pip install -U numpy
RUN pip install -U matplotlib
RUN pip install -U chumpy
# Eigen
RUN apt-get -y install \
    libboost-all-dev \
    libeigen3-dev \
    libomp-dev \
    make \
    cmake \
    g++
# Open CV
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libxext6
RUN pip install -U opencv-python
RUN pip install -U opencv-contrib-python
# OpenDR
RUN apt-get install -y python3.8-venv libfreetype6-dev git build-essential cmake python3-dev wget libopenblas-dev libsndfile1 libboost-dev libeigen3-dev
ENV DISABLE_BCOLZ_AVX2=true
RUN pip install opendr-toolkit-engine
RUN pip install opendr-toolkit
# MPI-IS/mesh
RUN apt-get install -y libboost-dev
WORKDIR /tmp
RUN git clone https://github.com/MPI-IS/mesh.git
WORKDIR /tmp/mesh
RUN whereis boost
RUN BOOST_INCLUDE_DIRS=/usr/include/boost make all
# SMPL


# clean
RUN rm -rf /var/lib/apt/lists/*
