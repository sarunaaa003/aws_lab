# provider core reqs
variable "account_id" {}
variable "aws_profile" {}
variable "PARENT_credentials_file" {}

# environemnt
variable "region" {}
variable "region_azs" {}

# remote states
variable "PARENT_tf_s3_bucket" {}
variable "PARENT_tf_s3_key" {}
variable "PARENT_aws_profile" {}

# convenience
variable "keypair" {}
variable "generic_owner" {}


# cidrs in use
variable "cidr_prd" {}
variable "cidr_dev" {}
variable "cidr_qat" {}
variable "cidr_cmn" {}
variable "cidr_home" {}

#VPC Peering
variable "peer_owner_id" {}
