# Anything CAPITAL are modules to reuse the code
#Before start ensure you are in the right directory and right remote config is updated

cd /cygdrive/c/aws/account/app/bind/cmn

terraform remote config -backend=s3 -backend-config="bucket=tf-account" -backend-config="key=app/bind/cmn/terraform.tfstate" -backend-config="region=us-east-1"

terraform plan -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"


terraform apply -var-file="../../../infra/infra.tfvars" -var-file="../../../infra/cmn/cmn.tfvars"

#To DO
# CHECK THE LOGIN
# ADD MULTIPLE SECURITY GROUP LAYERS
