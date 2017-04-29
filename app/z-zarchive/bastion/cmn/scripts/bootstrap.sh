#!/bin/bash

echo "----------------------------------------------------"
echo "-------------     BEGIN USER-DATA     --------------"
echo "----------------------------------------------------"

#export HTTP_PROXY=intrproxy.aws.mm-corp.net:80
#export HTTPS_PROXY=intrproxy.aws.mm-corp.net:80
#echo 'export no_proxy="docker.mm-corp.net,.mm-corp.net,chef.aws.mm-corp.net,10.201.*,10.201.141.220,10.201.141.219,10.201.141.221,10.201.155.172,10.201.155.171,ip-*,.us-west-1.compute.internal,*.us-west-1.compute.internal,instance-data"' >> /etc/profile.d/intrproxy.sh
#export no_proxy="docker.mm-corp.net,.mm-corp.net,chef.aws.mm-corp.net,10.201.*,10.201.141.220,10.201.141.219,10.201.141.221,10.201.155.172,10.201.155.171,ip-*,.us-west-1.compute.internal,*.us-west-1.compute.internal,instance-data"
yum update -y

echo "----------------------------------------------------"
echo "------------- BEGIN USER-DATA - CREDS --------------"
echo "----------------------------------------------------"

#for user in aaron ajanta arun prabhuanand;do useradd -G sysops $user; mkdir /home/$user/.ssh; touch /home/$user/.ssh/authorized_keys; done
#echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7FOlZNaIzAQHoYtQI4b5o+mwNLWokGi5gjifHWKQ+7Y1TXsN2hVN2rHm+EM4RlaRDWq8Ly9bhdTGH0uY0HTIPyKHd5GWCKv6Aqo1lL5vH0AZz6EWYwQdOoyz18OJYAYx9FxDn06Q9zo1Biscb48Azs7wc6bxOh4xVjB7poxsd6vJ0W+WegD17ukOT34E98mvPBdVDqcc1EaTiIdqOI1rztmZIx1lWjeAkuL2yiKU5YQnOioTpsyL7x8qLkzsPMOhNZqLBEI7KjfioYZV0VssL+fgOiYDt0BEr0Tmx+GaQIXtJo239FEo58rbL4zSF1vfdy5EWTGBPGPlcGNZkKVe7/5pp6fX7NLZQ2xsD8qOf61+0tdYcL2Tq7p3frZEmKjiYTkslP+CuO4leCk8oQJ37nV3gnZrO3IP0Me4QT29HH+NRym1zmXuya9VOP9fGJReu20PRynaM2LFAWySru9iq4jjEiBwMsBuX+OpKqe2FKqpqLWZFU5/9YAAJMz4ou/5vSfIZpDaOj6hm+9b160etqZeN6nptbhNWqcBLSgjvynkF1l+6nw2zghle2QUOKeT2TlYSES/K/XxuuVGHmaefYTyzb7Sb7qz+zQMaBCN8Q6fx22WsTdjfad6+yHBQGb4rvnqqi7ev60bfWTgNgBGZ/o0WH5qZ1CtP6lBbFlAAqQ== aaron.caito@gmail.com >> /home/aaron/.ssh/authorized_keys
#echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/eJw50J0GT/pEfiytv7xv3R/oF/50FawGp77BtkfLIuk4RnCP6daWilb4kF8scGPanhMdCl/XZ7orbHnnY2JFNkkzoiD9dGsnzzsOnoh8t+L0IGZRjsW2vxDgeAojM6d1+fhn0qI/pFmKBZCNOm9+1oov9qf+GIhYJt4JlqHwL895mbZ0pZucCxGn4PBARAgbufaaBhprQBjv0xArfjkaA9CUQZfXWcrDiKA4duUPDfA7PsnqYPs/aeaPM8cuFLXBhXYfz+TFcPH13OMVlAMzxq5jEZjq4l8nMHHSR5vK3qiSROZqOPn/4EFLJBlqba/H/eZy1UhFG7E5D0B2alLN aadhikari@markmonitor.com >> /home/ajanta/.ssh/authorized_keys
#echo ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkb7UlobiFGzFjp8bFkELE40e5uFht0LTsfe6lSV30Z3p6BrzNJQG1hTC4JGYBvzru3qAjgOGHvqLBb9XhwpzFeWlGm56Dl9BJCdOP/8uvEZIjnGs4icpEey9lOMuvPAAY/P8jNew2LrsD0tBT0UYHwG9eSyxa7I3kNpTt/6z0x5aYIdJWbjDPbLibX5cOvqzpnfM+aV48epKv8/c9Rx/hguziSIpD41A1Zpd1QIHuKrg6oOdQ97G4O5WjhbWBFthI1VpdDUeSR09LAWux6T5TgjSWpFl3lgk41QMnzeTtV4lr2d8ONuENItBmTF3zxPd2DJ6XqHYP8BtDH7xlJrrhw== rsa-key-20160528 >> /home/arun/.ssh/authorized_keys
#echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMhzvTwwXlk2JB/qbi7CYKAF90zreuSoYeNQauwTE/iLEinTHft+LoUPqpe8BOttgc16Sr5oVzGqk5K3PJBiQxZ3z9j1ZMN9eZL9a4U5BH3apzSkUHolLIj32vL5hOBq6XHnWayeELXObCicuMS9M5BdETbSUVqBDT4Wu7sGm/2OsWvcAQBliGA3oDwdG8u7zki/KBOl20RLH1z7dfNNbZZ5E6qCQhEu+8Dvx55CWdC4lWUaIKRBs3wGNMBkeMoLeiL/j2NKpGLU0jUNVg3/ppQ8NLU641tHzhfXLM21ulnSSRZ5S2tEVa4ivBWfMMqokwFd5FHcOYwKYa3QojU+EV psivashanmugam@ubuntu >> /home/prabhuanand/.ssh/authorized_keys
#for user in aaron ajanta arun prabhuanand; do chmod 700 /home/$user/.ssh; chmod 600 /home/$user/.ssh/authorized_keys; chown -R $user:$user /home/$user/.ssh; echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$user; chmod 600 /etc/sudoers.d/$user; done

echo "----------------------------------------------------"
echo "------------------  END CREDENTIALS ----------------"
echo "----------------------------------------------------"

#HOST_NAME=`hostname`
#PRIVATE_IP_ADDRESS=$(ifconfig $1 | grep "inet 10.20" | awk -F: '{print $1}' | awk '{print $2}')
#echo "noproxy = "$no_proxy
#echo '{"Comment": "Terraform added via bootstrap-member.sh","Changes": [{"Action": "UPSERT","ResourceRecordSet": {"Name": "'$HOST_NAME'.aws.mm-corp.net.","Type": "A","TTL": 300,"ResourceRecords": [{"Value": "'$PRIVATE_IP_ADDRESS'"}]}}]}' > r53-rs-update.json
#echo "script generated"
#cat r53-rs-update.json

#export AWS_ACCESS_KEY_ID=AKIAIZPEJCROKWMJKPSA
#export AWS_SECRET_ACCESS_KEY=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
#echo "route53 api call follows"
#aws route53 change-resource-record-sets --hosted-zone-id Z20AD1NKSN5Y2P --change-batch file://r53-rs-update.json
#echo "route53 api call completed"
#unset AWS_ACCESS_KEY_ID
#unset AWS_SECRET_ACCESS_KEY
#rm r53-rs-update.json

#echo $PRIVATE_IP_ADDRESS $HOST_NAME".aws.mm-corp.net" >> /etc/hosts
#hostnamectl set-hostname "`hostname`.aws.mm-corp.net"

echo "----------------------------------------------------"
echo "--------------- END CLOUD USER-DATA ----------------"
echo "----------------------------------------------------"
