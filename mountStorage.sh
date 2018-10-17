set -x

sudo yum -y install nfs-utils-lib
sudo mount -t nfs 192.168.1.3:/scratch /mnt/scratch

vi /etc/fsab
192.168.1.3:/scratch /mnt nfs default 0 0
