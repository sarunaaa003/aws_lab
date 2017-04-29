pwd
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=APP/tf-template/cmn/terraform.tfstate" -backend-config="region=us-east-1"
sleep 5
terraform apply -var-file="../../infra/infra.tfvars" -var-file="../../infra/cmn/cmn.tfvars" -var-file="stack.tfvars"
sleep 5s
