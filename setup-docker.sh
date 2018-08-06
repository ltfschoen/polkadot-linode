# Run with:
#   cd /Users/Ls/code/linode;
#   ssh root@172.104.142.185 ARG2="arg2" 'bash -s' < setup-docker.sh; 
#   ssh root@172.104.142.185;

# System info, set hostname and timezone
hostnamectl set-hostname scon
timedatectl set-timezone 'Australia/Sydney'
uname -a

# Setup Docker CE
#
# References:
# - https://www.linode.com/docs/getting-started/
# - Install Docker CE
#   - https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1
#   - https://unix.stackexchange.com/questions/363048/unable-to-locate-package-docker-ce-on-a-64bit-ubuntu
#   - https://www.linode.com/docs/applications/containers/what-is-docker/
#
# Steps
# - Build Ubuntu 18.04 LTS wih Linode, Boot
# - Remote access with `ssh-keygen -R 172.104.142.185; ssh root@172.104.142.185`
apt-get install -y apt-transport-https ca-certificates curl software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test";
apt-get -y update && apt-get -y upgrade;
apt install -y docker-ce docker-compose;
docker --version;