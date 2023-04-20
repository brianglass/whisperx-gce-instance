DISTRO="ubuntu"
VERSION="2204"
ARCH="x86_64"

apt-get update
add-apt-repository -y universe multiverse

apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/$DISTRO$VERSION/$ARCH/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb

apt-get update

apt-get -y install build-essential linux-headers-$(uname -r)
apt-get -y install ffmpeg
apt-get -y install cuda nvidia-gds

# Add CUDA to global PATH for all users
sed -e 's|PATH="\(.*\)"|PATH="/usr/local/cuda-12.0/bin:\1"|g' -i /etc/environment 

# Later pips seem to break the install of whisperx
apt-get -y install python3-pip python3-virtualenv
pip install -U pip==21.3.1
pip install git+https://github.com/m-bain/whisperx.git
