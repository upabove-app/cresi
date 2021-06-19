#!/usr/bin/env bash

#nvidia-docker run -it -v /raid:/raid -v /nfs:/nfs --rm -ti --ipc=host --name cresi_v3 cresi_v3_image

# This docker command hardcodes where the data is located (the second volume mapping). You need to change this if you run anywhere else and until nfs/minio storage is available. 
# Run this shell script from the ROOT of your workspace. eg ./docker/gpu/docker-run.sh
# after the docker is launched from within docker `conda acticate cresi` to enter the environment of this project
docker run --user $(id -u):$(id -g) --gpus all --shm-size 8G -it --rm  --ipc=host -v ${PWD}:/workspace -v /data-1/s3:/data cresi_v4_image bash