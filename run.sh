#!/bin/bash

# init
project=$(cd ~/Documents/Projects/smalr_online && pwd)

# run
run_cmd="python main.py"

docker build -t denden047/smalr_online docker && \
docker run -it --rm \
    -v="${project}:/work" \
    -w="/work/src" \
    denden047/smalr_online \
    ${run_cmd}
