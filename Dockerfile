ARG PYTORCH="1.13.0"
ARG CUDA="11.6"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

# To fix GPG key error when running apt-get update
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN apt-get update && apt-get install -y git
RUN pip install -U pip

RUN conda clean --all

# Install HumanRF
WORKDIR /
RUN git clone --depth=1 --recursive https://github.com/synthesiaresearch/humanrf

# Install GLM
RUN apt-get install -y libglm-dev
RUN apt-get install -y ffmpeg libsm6 libxext6

# Install required packages and Tiny CUDA NN.
WORKDIR /humanrf
RUN pip install -r requirements.txt
# RUN pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

# Install ActorsHQ package (dataset and data loader)
WORKDIR /humanrf/actorshq
RUN pip3 install .

# # Install HumanRF package (method)
# cd ../humanrf
# pip3 install .

ENV PYTHONPATH=$PYTHONPATH:/path/to/repo

WORKDIR /humanrf