#!/bin/bash

# init
export DOCKER_DEFAULT_PLATFORM=linux/amd64
project=$(cd ~/Documents/Projects/smalr_online && pwd)

# run
run_cmd="python main.py"

docker build -t denden047/smalr_online . && \
docker run -it --rm \
    -v="${project}:/work" \
    -w="/work/src" \
    denden047/smalr_online \
    /bin/bash
    # ${run_cmd}
