#!/bin/sh
sudo yum -y install nfs-utils nfs-utils-lib
sudo yum -y install portmap

sudo chkconfig nfs on
sudo service rpcbind start
sudo service nfs start
sudo mkdir /software
sudo mkdir /scratch
#sleep 600
#sleep 300
sudo mount -t nfs 192.168.1.1:/software /software
sudo mount -t nfs 192.168.1.2:/scratch /scratch

sleep 30

echo "export PATH='$PATH:/software/bin'" >> /users/BC843101/.bashrc
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/software/lib/'" >> /users/BC843101/.bashrc
source /users/BC843101/.bashrc
