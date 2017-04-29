export AWS_ACCESS_KEY_ID="AKIAI7ZQZ36DHPOFNAWQ"
export AWS_SECRET_ACCESS_KEY="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"
sleep 5

#QAT Project to create QAT VPC
cd qat
pwd
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/qat/terraform.tfstate" -backend-config="region=us-east-1"
sleep 5
terraform destroy -var-file="../infra.tfvars" -var-file="qat.tfvars"
sleep 5

#DEV Project to create DEV VPC
cd ../dev
pwd
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/dev/terraform.tfstate" -backend-config="region=us-east-1"
sleep 5
terraform destroy -var-file="../infra.tfvars" -var-file="dev.tfvars"
sleep 5

#CMN Project to create CMN VPC
cd ../cmn
pwd
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/cmn/terraform.tfstate" -backend-config="region=us-east-1"
sleep 5
terraform destroy -var-file="../infra.tfvars" -var-file="cmn.tfvars"
sleep 10


#Master Project to create VPC's
cd ..
pwd
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=infra/terraform.tfstate" -backend-config="region=us-east-1"
sleep 5
terraform destroy -var-file="infra.tfvars"
sleep 10
