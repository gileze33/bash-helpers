#! /bin/bash

# usage: TBC

if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi


echo "rabbit" > /etc/hostname
echo "127.0.0.1 rabbit" >> /etc/hosts
hostname -F /etc/hostname


yum install -y gcc gcc-c++ make libxslt fop ncurses-devel openssl-devel *openjdk-devel unixODBC unixODBC-devel

sudo yum -y install erlang



mkdir RabbitServer

cd RabbitServer

wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.5/rabbitmq-server-3.1.5-1.noarch.rpm

rpm -i rabbitmq-server-3.1.5-1.noarch.rpm

rabbitmq-plugins enable rabbitmq_management
chkconfig rabbitmq-server on
shutdown -r now