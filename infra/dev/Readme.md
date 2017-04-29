#To create multiple VPC's duplicate this Folder and follow instructions on each file

#Before start ensure you are in the right directory and right remote config is updated

cd /cygdrive/c/aws/account/infra/dev

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/dev/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../infra.tfvars" -var-file="dev.tfvars"

terraform apply -var-file="../infra.tfvars" -var-file="dev.tfvars"
