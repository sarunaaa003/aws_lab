#Provider
variable "region" {}
variable "aws_profile" {}
variable "PARENT_credentials_file" {}

#Remote state
variable "PARENT_tf_s3_bucket" {}
variable "tf_s3_key"{}

# environment
variable "environment" {}
variable "stack" {
  default = "consul"
}

# cidrs in use
variable "cidr_home" {}
variable "cidr_cmn" {}

#tags
variable "owner" {
  default = "arunkums@gmail.com"
}
variable "business_unit" {
  default = "ITOPS"
}

variable "renewal_date" {
  default = "2017.07.01"
}
variable "role_app" {
  default = "consul"
}

# app variable
variable "app_ami"{
  default = "ami-6869aa05"
}
variable "app_instance_type" {
  default = "t2.micro"
}
variable "app_instance_vol_size" {
  default = "8"
}
variable "leader" {
  default = 1
}
variable "consul" {
  default = 3
}
variable "keypair" {
  default = "arun.kumar"
}
