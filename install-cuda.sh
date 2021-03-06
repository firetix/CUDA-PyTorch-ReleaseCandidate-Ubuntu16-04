#!/bin/bash


echo -e "\e[96mDownloading CUDNN Release Candidate"
# Download the CUDNN Release Candidate 
echo -e "\e[97m"
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0-rc.tgz

#cd CUDA-PyTorch-ReleaseCandidate-Ubuntu16-04
sudo chmod +x cudnn-8.0-linux-x64-v6.0-rc.tgz

echo -e "\e[96mUpdating System"
echo -e "\e[97m"
# Update the system
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install linux-image-extra-`uname -r`

echo -e "\e[96mDownloading NVIDIA GPU Driver"
echo -e "\e[97m"
# Get the NVIDIA Driver
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.57/NVIDIA-Linux-x86_64-367.57.run -O nvidia_driver.run
sudo chmod +x nvidia_driver.run
echo -e "\e[96mInstalling NVIDIA GPU Driver"
echo -e "\e[97m"
sudo sh nvidia_driver.run

# the GPU driver installation will complain about paths and/or 32 bit not found, just accept
# Say YES to running the nvidia-xconfig utility to auto update when restarting

echo -e "\e[96mDownloading CUDA"
echo -e "\e[97m"
# Download CUDA
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run -O cuda_8.0.run

# Change permissions and run the install script
sudo chmod +x nvidia_driver.run
sudo sh nvidia_driver.run

echo -e "\e[96mInstalling CUDA"
echo -e "\e[97m"
# Run the CUDA script
mkdir -p extracts
sudo sh cuda_8.0.run --extract=`pwd`/extracts
sudo chmod +x ./extracts/*
sudo sh ./extracts/cuda-linux64-rel-8.0.61-21551265.run

    # Accept License
    # Accept default install paths
    # Say NO to shortcuts
    # Say YES to create symbolic links

    # Confirm....
    # - PATH includes /usr/local/cuda-8.0/bin
    # - LD_LIBRARY_PATH includes /usr/local/cuda-8.0/lib64, 
    #   or, add /usr/local/cuda-8.0/lib64 to /etc/ld.so.conf and run ldconfig as root

# Untar, copy to system, and clean up
tar xf cudnn-8.0-linux-x64-v6.0-rc.tgz
sudo cp cuda/lib64/* /usr/local/cuda/lib64/
sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
echo -e "export CUDA_HOME=/usr/local/cuda\nexport PATH=\$PATH:\$CUDA_HOME/bin\nexport LD_LIBRARY_PATH=\$LD_LINKER_PATH:\$CUDA_HOME/lib64" | tee -a ~/.bashrc ~/.zshrc
sudo rm -rf cuda cuda_8.0.run extracts nvidia_driver.run
sudo rm -rf cudnn-8.0-linux-x64-v6.0-rc.tgz

