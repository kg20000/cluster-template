#!/bin/sh
set -x

sudo yum -y install nfs-utils


yum install -y nfs-utils nfs-utils-lib
chkconfig nfs on
service rpcbind start
service nfs start
mkdir /software
mkdir /scratch
touch /scratch/machine_list
touch /etc/exports

for i in range (2,13):
  echo "/software 192.168.1." + i + "(rw,sync,no_root_squash)" >> /etc/exports
  echo "/scratch compute-" + i + "(rw,sync,no_root_squash)" >> /scratch/machine_list
  
	#echo "/software 192.168.1." + i + "(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
	#echo "/software compute-" + i + "(rw,sync,no_root_squash)" >> /etc/exports

sudo mount -t nfs 192.168.1.2:/scratch /scratch

sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service

sudo mkdir /scratch
mpicc /scratch/hello.c -o /scratch/hello
sudo chmod 755 /scratch


sudo mv /local/repository/exports /etc/exports

sudo exportfs -a
