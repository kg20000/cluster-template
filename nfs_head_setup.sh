#!/bin/bash
sudo yum -y install nfs-utils nfs-utils-lib
chkconfig nfs on
service rpcbind start
service nfs start
mkdir /software
chmod 777 /software

# Create the permissions file for the NFS directory.
computes=$(($1 + 1))
for i in $(seq $computes)
do
  st='/software 192.168.1.'
  st+=$(($i))
  st+='(rw,sync,no_root_squash,no_subtree_check)'
  echo $st >> /etc/exports
done

for i in range (1,13):
	sudo echo "/software compute-" + i + "(rw,sync,no_root_squash)" >> /etc/exports

#sudo service nfs start
#sudo service portmap start
#sudo mkdir /mnt/scratch
#sudo mount -t nfs storage:/scratch /mnt/scratch

set -x
sudo yum -y group install "Development Tools"
cd software
sudo wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.2.tar.gz
sudo tar xzf openmpi-3.1.2.tar.gz
cd openmpi-3.1.2
sudo ./configure --prefix=/opt/openmpi/3.1.2
sudo make
sudo make all install
#echo "export PATH='$PATH:/opt/openmpi/3.1.2/bin'" >> /users/BC843101/.bashrc
#echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/openmpi/3.1.2/lib/'" >> /users/BC843101/.bashrc
#Modified PATHS
echo "export PATH='$PATH:/software/bin'" >> /users/BC843101/.bashrc
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/software/bin'" >> /users/BC843101/.bashrc
cd ..
sudo rm -Rf openmpi-3.1.2
sudo rm -Rf openmpi-3.1.2.tar.gz
