#To create multiple VPC's duplicate this Folder and follow instructions on each file

#Before start ensure you are in the right directory and right remote config is updated, replace cmn with correct vpc name e.g. dev/qat

cd /cygdrive/c/aws/account/infra/qat

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/qat/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../infra.tfvars" -var-file="qat.tfvars"

terraform apply -var-file="../infra.tfvars" -var-file="qat.tfvars"
