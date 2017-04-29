# provider core reqs
variable "account_id" {}
variable "aws_profile" {}
variable "region" {}
variable "shared_credentials_file" {}

# convenience
variable "keypair" {}
variable "region_azs" {}


# remote states
variable "tf_s3_key" {}
variable "PARENT_tf_s3_bucket" {}

# environment
variable "environment" {}
#variable "r53_zone" {}
variable "stack" {}

# cidrs in use
#variable "cidr_vpn_110" {}
#variable "cidr_vpn_111" {}
#variable "cidr_vpn_112" {}

#tags
variable "owner" {}
variable "business_unit" {}
variable "renewal_date" {}


# app
variable "app_count_max" {}
variable "app_count_min" {}
variable "app_count_desired" {}
variable "app_type" {}
variable "app_role" {}
variable "app_root_size" {}
variable "ami_no_proxy" {}
