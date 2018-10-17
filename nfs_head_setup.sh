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

#exportfs -a
