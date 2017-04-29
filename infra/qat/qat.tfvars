##########################################################################################
##########################################################################################
#State File -
#Change *cmn* - to the corresponding VPC Name and create folder accordingly
#Change environment cmn to the corresponsing VPC name
#CIDR BLOCK SHOULD MATCH THE CIDR OF THE VPC in the infra.tfvars
##########################################################################################
##########################################################################################


tf_s3_key               = "infra/qat/terraform.tfstate"

#environment
environment             = "qat"

cidr_block_public = "10.22.0.0/20,10.22.16.0/20,10.22.32.0/20,10.22.48.0/20"
cidr_block_private = "10.22.128.0/20,10.22.144.0/20,10.22.160.0/20,10.22.176.0/20"

key                     = "arun.kumar"
