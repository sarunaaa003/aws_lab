# Anything CAPITAL are modules to reuse the code
#Before start ensure you are in the right directory and right remote config is updated

cd /cygdrive/c/aws/account/app/squid/cmn

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=app/squid/cmn/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"


terraform apply -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"

#To DO
# CHECK THE LOGIN
# ADD MULTIPLE SECURITY GROUP LAYERS

#Connecting to a Bastion Station
$ssh -A ec2-user@ec2-54-152-16-35.compute-1.amazonaws.com

#from there to connect to Private nodes just

$ssh 10.22.168.208

curl -I --proxy cmn-squid.casa.net:80 http://www.google.com
