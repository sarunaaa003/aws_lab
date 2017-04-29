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
  default = "bind"
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
  default = "Jump Host"
}

# app variable
variable "app_ami"{
  default = "ami-45e86552"
}
variable "app_instance_type" {
  default = "t2.micro"
}
variable "app_instance_vol_size" {
  default = "40"
}
variable "app_count_max" {
  default = 1
}
variable "app_count_min" {
  default = 1
}
variable "app_count_desired" {
  default = 1
}
variable "keypair" {
  default = "arun.kumar"
}
