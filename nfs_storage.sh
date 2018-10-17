#!/bin/sh

sudo yum -y install nfs-utils nfs-utils-lib
/etc/init.d/nfs start
/etc/init.d/nfs start
chkconfig --level 35 portmap on
chkconfig --level 35 nfs on

chkconfig nfs on
service rpcbind start
service nfs start
#mkdir /software
sudo mkdir /scratch
touch /scratch/machine_list
touch /etc/exports

for i in range (2,13):
  echo "/software 192.168.1." + i + "(rw,sync,no_root_squash)" >> /etc/exports
  echo "/scratch compute-" + i + "(rw,sync,no_root_squash)" >> /scratch/machine_list
  
	#echo "/software 192.168.1." + i + "(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
	#echo "/software compute-" + i + "(rw,sync,no_root_squash)" >> /etc/exports

sleep 180
sudo mount -t nfs 192.168.1.1:/software /software
sudo mount -t nfs 192.168.1.2:/scratch /scratch

#sudo systemctl enable nfs-server.service
#sudo systemctl start nfs-server.service

cp /local/repository/source/* /scratch

sudo mkdir /scratch
mpicc /scratch/hello.c -o /scratch/hello
sudo chmod 755 /scratch

#mpicc /scratch/pi_mc.c -o /scratch/pi_mc
#chmod 755 /scratch/pi_mc

sudo mv /local/repository/exports /etc/exports

sudo exportfs -a
