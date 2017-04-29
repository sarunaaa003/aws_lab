# Anything CAPITAL are modules to reuse the code
#Before start ensure you are in the right directory and right remote config is updated

#Route53 Record set in SQUID is a dependency for this app's bootstrap

cd /cygdrive/c/aws/account/app/consul-leader/cmn

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=app/consul-leader/cmn/terraform.tfstate" -backend-config="region=us-east-1"

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
#Manually Join the Cluster
$./consul join </tmp/leader.txt address>

Terminate the session by closing the window
#Route 53 Option to create Record Set needs to be explored
#ADD ELB TO both the stack and create ROUTE 53 entries for each stack /
#Register Servers using Leader Route53
#Leader R53 Record set will get terminated after initial registration
#Server R53 Record will be used by Clients for registration
