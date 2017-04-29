#To create multiple VPC's duplicate this Folder and follow instructions on each file, Remove the State file on the target Folder

#Before start ensure you are in the right directory and right remote config is updated

cd /cygdrive/c/aws/account/infra/cmn

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/cmn/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../infra.tfvars" -var-file="cmn.tfvars"

terraform apply -var-file="../infra.tfvars" -var-file="cmn.tfvars"
