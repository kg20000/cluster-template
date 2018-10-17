set -x

sudo yum -y install nfs-utils

sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service

sudo mkdir /scratch
sudo chmod 777 /scratch

sudo mv /local/repository/exports /etc/exports

sudo exportfs -a
