#!/bin/bash
if [ $(id -u) != "0" ]
then
    echo "############################################################################"
    echo "## "
    echo "## Installing on the dependencies for OgreVim on Ubuntu LTS 12.04"
    echo "## "
    echo "## This scipt is primarily used for setting up test VMs"
    echo "## "
    echo "## You must have sudo privileges to run this script!"
    echo "## "
    echo "## You cannot run this script as root!"
    echo "## "
    echo "############################################################################"

    echo "############################################################################"
    echo "## "
    echo "## Installing dependencies"
    echo "## "
    echo "############################################################################"

    sudo apt-get install \
        build-essential \
        automake \
        libtool \
        libfreetype6-dev \
        libfreGeimage-dev \
        libzzip-dev \
        libxrandr-dev \
        libxaw7-dev \
        freeglut3-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        nvidia-cg-toolkit \
        libois-dev \
        libboost-thread-dev \
        doxygen \
        graphviz \
        libcppunit-dev cmake 

else
    echo "############################################################################"
    echo "##"
    echo "## You cannot run this script with root."
    echo "##"
    echo "############################################################################"
fi
