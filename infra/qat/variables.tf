# provider core reqs
#variable "account_id" {}
variable "aws_profile" {}
variable "PARENT_credentials_file" {}

# environemnt
variable "region" {}
variable "region_azs" {}
variable "environment" {}

# remote states
variable "PARENT_tf_s3_bucket" {}
variable "PARENT_tf_s3_key" {}
variable "tf_s3_key"{}
#variable "PARENT_aws_profile" {}

# convenience
#variable "keypair" {}
variable "generic_owner" {}

# subnet scoping
variable "cidr_block_public" {}
variable "cidr_block_private" {}
variable "cidr_home" {}
