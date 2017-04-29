#This is Master Project, Only required VPC's and VPC Peering's are being created here
#output.tf needs to be updated for additional resources being created

cd <replaceme>/account/infra

aws configure

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/terraform.tfstate" -backend-config="region=us-east-1"

export AWS_ACCESS_KEY_ID="dfgdfge"
export AWS_SECRET_ACCESS_KEY="sdfsdfs"


terraform plan  -var-file="infra.tfvars"

terraform apply  -var-file="infra.tfvars"

 terraform graph | terraform-iconify | dot -Tpng > infra.png
