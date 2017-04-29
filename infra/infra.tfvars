#convenience
account_id              = "814296344053"
key                     = "arun.kumar"
keypair                 = "arun.kumar"
generic_owner           = "arun.kumar"
PARENT_credentials_file = "../../keys"
aws_profile             = "arun.kumar"
PARENT_aws_profile      = "arun.kumar"

#environment
region                  = "us-east-1"
region_azs              = "us-east-1a,us-east-1b,us-east-1d"

# cidrs in use
cidr_cmn          =  "10.20.0.0/16"
cidr_dev          =  "10.21.0.0/16"
cidr_qat          =  "10.22.0.0/16"

cidr_prd          =  "10.23.0.0/16"
cidr_home         =  "192.168.0.0/24"

#State File
PARENT_tf_s3_bucket            = "tf-account"
PARENT_tf_s3_key               = "infra/terraform.tfstate"

# VPC Peering
peer_owner_id     = "814296344053"
