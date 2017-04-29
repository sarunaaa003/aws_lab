#!/bin/bash

yum update -y

aws s3 cp s3://tf-squid/squid.conf /etc/squid/squid.conf

# Launch services
service squid stop
chkconfig squid on
service squid start
