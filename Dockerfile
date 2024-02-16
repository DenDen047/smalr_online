FROM python:3.8


RUN apt-get update && apt-get install -y git
RUN pip install -U pip

RUN pip install chumpy
RUN pip install opencv-python
RUN pip install matplotlib
RUN pip install scikit-learn

RUN apt-get install -y build-essential libgl1-mesa-dev  libglu1-mesa-dev freeglut3-dev libosmesa6-dev
RUN pip install opendr

# Mesh Library
WORKDIR /tmp
RUN git clone https://github.com/MPI-IS/mesh.git
WORKDIR /tmp/mesh
RUN apt-get install -y libboost-dev
# for the bug in the Makefile (https://github.com/MPI-IS/mesh/issues/89#issuecomment-1783731468)
RUN sed -i 's/--install-option/--config-settings/g' Makefile
RUN BOOST_INCLUDE_DIRS=/usr/include make all

# Eigen
WORKDIR /tmp
RUN wget https://gitlab.com/libeigen/eigen/-/archive/3.4-rc1/eigen-3.4-rc1.tar.gz
RUN tar -xf eigen-3.4-rc1.tar.gz

# SMPL
ADD . /smalr_online
RUN cd /smalr_online/src/smalr/sbody/alignment/mesh_distance && make

# Fixing the some bugs of OpenDR
RUN pip install numpy==1.23.1
RUN sed -i 's/np.repeat(np.arange(self.v.r.size*2\/3), 3)/np.repeat(np.arange(self.v.r.size*2\/\/3), 3)/g' /usr/local/lib/python3.8/site-packages/opendr/camera.py


WORKDIR /smalr_online
