#!/bin/bash
TARGETDIR="$HOME/.tmp"

echo "creating target dir and cd to it"
mkdir $TARGETDIR && cd $TARGETDIR

echo -e "Checking huge pages\n"
echo -e "Current value:\n"
sysctl vm.nr_hugepages -n

if [ $(sysctl vm.nr_hugepages -n) -eq "0" ]; then
   echo "Fixing vm.nr_hugepages=0";
   sudo sysctl vm.nr_hugepages=128
   echo "vm.nr_hugepages = 128" | sudo tee -a /etc/sysctl.conf
fi

echo -e "Installing dependencies\n"
sudo apt -y install git build-essential cmake libuv1-dev libmicrohttpd-dev

echo -e "Clonning xmrig repo"
git clone https://github.com/xmrig/xmrig.git

echo " cd $TARGETDIR/xmrig/build, copying systemd service xmr-cpu.service to /etc/systemd/system/"
sudo cp -f
