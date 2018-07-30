# System info, set hostname and timezone
uname -a
hostname
hostnamectl set-hostname scon
timedatectl set-timezone 'Australia/Sydney'
date

# View TCP ports with listening daemons
netstat -ltn

# View iptables firewall status
# https://help.ubuntu.com/community/IptablesHowTo
iptables -L -n