#!/bin/bash
sudo yum -y install nfs-utils nfs-utils-lib
chkconfig nfs on
service rpcbind start
service nfs start
mkdir /software
chmod 755 /software

for i in range (2,13):
	echo "/software 192.168.1." + i + "(rw,sync,no_root_squash)" >> /etc/exports
	#echo "/software 192.168.1." + i + "(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
	#echo "/software compute-" + i + "(rw,sync,no_root_squash)" >> /etc/exports

#sudo service rpcbind start
#sudo service nfs start
#sudo service portmap start
#sudo mkdir /mnt/scratch
#sudo mount -t nfs storage:/scratch /mnt/scratch
#mkdir /software
#mount -t nfs 192.168.1.1:/software /software

exportfs -a

set -x
sudo yum -y group install "Development Tools"
cd /software
sudo wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.2.tar.gz
sudo tar xzf openmpi-3.1.2.tar.gz
cd openmpi-3.1.2
sudo ./configure --prefix=/software
sudo make
sudo make all install
#echo "export PATH='$PATH:/opt/openmpi/3.1.2/bin'" >> /users/BC843101/.bashrc
#echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/openmpi/3.1.2/lib/'" >> /users/BC843101/.bashrc
#Modified PATHS
echo "export PATH='$PATH:/software/bin'" >> /users/BC843101/.bashrc
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/software/lib'" >> /users/BC843101/.bashrc
cd ..
mkdir /software/testFolder
sudo rm -Rf openmpi-3.1.2
sudo rm -Rf openmpi-3.1.2.tar.gz
