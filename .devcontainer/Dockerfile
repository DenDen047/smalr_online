FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && \
    apt-get --yes install git sudo
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Clone the repo and install the OpenDR toolkit
RUN git clone --depth 1 --recurse-submodules -j8 https://github.com/opendr-eu/opendr -b master
WORKDIR "/opendr"
COPY opendr_install.sh .
RUN ./opendr_install.sh

# pkg
RUN pip install -U numpy
RUN pip install -U matplotlib
RUN pip install -U chumpy
RUN pip install -U scikit-learn
# OpenCV
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libxext6
RUN pip install -U opencv-python
RUN pip install -U opencv-contrib-python
# # MPI-IS/mesh
# RUN apt-get install -y libboost-dev
# WORKDIR /tmp
# RUN git clone https://github.com/MPI-IS/mesh.git
# WORKDIR /tmp/mesh
# RUN echo ${BOOST_INCLUDE_DIRS}
# RUN make all
# # Eigen
# WORKDIR /tmp
# RUN git clone https://gitlab.com/libeigen/eigen.git
# # SMPL



# # Create script for starting Jupyter Notebook
# RUN /bin/bash -c "source ./bin/activate.sh; pip3 install jupyter"
# RUN echo "#!/bin/bash\n source ./bin/activate.sh\n ./venv/bin/jupyter notebook --port=8888 --no-browser --ip 0.0.0.0 --allow-root" > start.sh
# RUN chmod +x start.sh

# # Start Jupyter Notebook inside OpenDR
# CMD ["./start.sh"]

# clean
RUN rm -rf /var/lib/apt/lists/*
