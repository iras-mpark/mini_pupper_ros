#!/bin/bash
######################################################################################
# ROS2
#
# This stack will consist of ROS2 install
#
# To install
#    ./pc_install.sh
######################################################################################

# Update package lists
cd ~
sudo apt update

# Create ROS 2 workspace and clone Mini Pupper ROS repository
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
if ! [ -d "mini_pupper_ros" ]; then
  git clone https://github.com/iras-mpark/mini_pupper_ros.git -b ros2-dev mini_pupper_ros
fi
vcs import < mini_pupper_ros/.minipupper.repos --recursive

# Install dependencies and build the ROS 2 packages
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
sudo apt install ros-$ROS_DISTRO-teleop-twist-keyboard ros-$ROS_DISTRO-teleop-twist-joy
sudo apt install -y ros-$ROS_DISTRO-v4l2-camera ros-$ROS_DISTRO-image-transport-plugins
sudo apt install ros-$ROS_DISTRO-rqt*
pip3 install simple_pid
colcon build --symlink-install
