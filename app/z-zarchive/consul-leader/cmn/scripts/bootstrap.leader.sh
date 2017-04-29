#!/usr/bin/env bash
#Proxy Configuration
export HTTP_PROXY=cmn-squid.casa.net:80
export HTTPS_PROXY=cmn-squid.casa.net:80
#System Update
yum update -y
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install awscli
yum install unzip
#Create Common Directories
mkdir -p /etc/consul.d/bootstrap
mkdir /var/consul
#Config Files Download
aws s3 cp s3://tf-consul/config-leader.json /etc/consul.d/bootstrap/config.json
aws s3 cp s3://tf-consul/consul.service /etc/systemd/system/consul.service
aws s3 cp s3://tf-consul/consul_0.6.4_linux_amd64.zip /tmp/consul.zip
#Config Files Upload
curl http://169.254.169.254/latest/meta-data/local-ipv4 >>/tmp/leader.txt
aws s3 cp /tmp/leader.txt s3://tf-consul/leader.txt
#Local Executables
mv /tmp/consul.zip /usr/local/bin/consul.zip
cd /usr/local/bin
unzip consul.zip
useradd consul
chown -R consul:consul /etc/consul.d/bootstrap/config.json
chown -R consul:consul /usr/local/bin/consul
chown -R consul:consul /var/consul
#Service Config
systemctl enable consul.service
#Service Start
runuser -l consul -c '/usr/local/bin/consul agent -config-dir=/etc/consul.d/bootstrap'
