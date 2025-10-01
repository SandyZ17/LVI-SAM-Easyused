docker run --privileged -it \
           -e NVIDIA_DRIVER_CAPABILITIES=all \
           -e NVIDIA_VISIBLE_DEVICES=all \
           --volume=${PWD}:/home/catkin_ws/src \
           --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
           --net=host --gpus=all \
           --ipc=host \
           --shm-size=1gb \
           --name=lvi_sam \
           --env="DISPLAY=$DISPLAY" \
           lvi_sam:test /bin/bash