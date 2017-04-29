export AWS_ACCESS_KEY_ID="AKIAILBN3P5TUCB7PXCA"
export AWS_SECRET_ACCESS_KEY="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"
cd /cygdrive/c/aws/account/app/bind/cmn
terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=app/bind/cmn/terraform.tfstate" -backend-config="region=us-east-1"
terraform plan -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"
terraform apply -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"
