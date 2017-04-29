##########################################################################################
##########################################################################################
#State File -
#Change *cmn* - to the corresponding VPC Name and create folder accordingly
#Change environment cmn to the corresponsing VPC name
#CIDR BLOCK SHOULD MATCH THE CIDR OF THE VPC in the infra.tfvars
##########################################################################################
##########################################################################################


tf_s3_key               = "infra/cmn/terraform.tfstate"

#environment
environment             = "cmn"

cidr_block_public = "10.20.0.0/20,10.20.16.0/20,10.20.32.0/20,10.20.48.0/20"
cidr_block_private = "10.20.128.0/20,10.20.144.0/20,10.20.160.0/20,10.20.176.0/20"

key                     = "arun.kumar"
