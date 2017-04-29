##########################################################################################
##########################################################################################
#State File -
#Change *cmn* - to the corresponding VPC Name and create folder accordingly
#Change environment cmn to the corresponsing VPC name
#CIDR BLOCK SHOULD MATCH THE CIDR OF THE VPC in the infra.tfvars
##########################################################################################
##########################################################################################


tf_s3_key               = "infra/dev/terraform.tfstate"

#environment
environment             = "dev"

cidr_block_public = "10.21.0.0/20,10.21.16.0/20,10.21.32.0/20,10.21.48.0/20"
cidr_block_private = "10.21.128.0/20,10.21.144.0/20,10.21.160.0/20,10.21.176.0/20"

key                     = "arun.kumar"
