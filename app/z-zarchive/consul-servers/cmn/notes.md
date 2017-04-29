#Refer to Consul-leader before executing Consul-server
# Anything CAPITAL are modules to reuse the code
#Before start ensure you are in the right directory and right remote config is updated

#Route53 Record set in SQUID is a dependency for this app's bootstrap

cd /cygdrive/c/aws/account/app/consul/cmn

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=app/consul-servers/cmn/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"


terraform apply -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"

#To DO
# CHECK THE LOGIN
# ADD MULTIPLE SECURITY GROUP LAYERS

#Connecting to a Bastion Station
$ssh -A ec2-user@bastion ip

#from there to connect to Private nodes just
$ssh consul instances
$ cd /usr/local/bin
$./consul join </tmp/leader.txt address>
Terminate the session by closing the window
