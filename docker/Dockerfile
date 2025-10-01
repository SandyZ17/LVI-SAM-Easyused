# Author: Chenyang Zhang
# email: tyoung96@yonsei.ac.kr

# FROM tyoung96/ros-melodic-cudagl11.2:latest
FROM vpd:ros-noetic-base-cuda

# Install PCL & Eigen & essential libraries
RUN apt-get update && apt-get install -y cmake libatlas-base-dev libeigen3-dev libpcl-dev libgoogle-glog-dev libsuitesparse-dev libglew-dev libboost-all-dev libtbb-dev

# Install ceres-solver
WORKDIR /home/thirdParty
RUN wget https://github.com/ceres-solver/ceres-solver/archive/refs/tags/1.14.0.tar.gz
RUN tar zxf 1.14.0.tar.gz
WORKDIR /home/thirdParty/ceres-solver-1.14.0

RUN mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ../../ceres-solver-1.14.0 && make -j"$(nproc)" && make install

# Install GTSAM
WORKDIR /home/thirdParty
RUN git clone --branch 4.0.3 https://github.com/borglab/gtsam.git
WORKDIR /home/thirdParty/gtsam
RUN mkdir build && cd build && \
    cmake -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_WITH_EIGEN_MKL=OFF \ -DGTSAM_WITH_EIGEN_MKL_OPENMP=OFF -DGTSAM_WITH_TBB=OFF .. && \
    make -j"$(nproc)" && make install
WORKDIR /home/catkin_ws

RUN apt install -y \
    ros-noetic-cv-bridge \
    ros-noetic-tf \
    ros-noetic-pcl-ros \
    ros-noetic-robot-localization \
    ros-noetic-fake-localization \
    ros-noetic-robot-state-publisher \
    ros-noetic-image-transport \
    ros-noetic-image-transport-plugins \
    ros-noetic-image-xacro \
    ros-noetic-rviz \
    libopencv-dev=4.2.0+dfsg-5

# Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
