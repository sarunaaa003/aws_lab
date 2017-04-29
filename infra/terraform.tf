# Kick it off
provider "aws" {
    region                  = "${var.region}"
    shared_credentials_file = "${var.PARENT_credentials_file}"
    profile                 = "${var.aws_profile}"
}

#VPC Construction
resource "aws_vpc" "vpc_cmn" {
  cidr_block            =   "${var.cidr_cmn}"
  enable_classiclink    =   "false"
  enable_dns_support    =   "true"
  enable_dns_hostnames  =   "true"
  instance_tenancy      =   "default"
  tags {
    "Terraform"         =   "true"
    "Name"              =   "cmn"
    "Owner"             =   "${var.generic_owner}"
  }
}
resource "aws_vpc" "vpc_dev" {
    cidr_block            =   "${var.cidr_dev}"
    enable_classiclink    =   "false"
    enable_dns_support    =   "true"
    enable_dns_hostnames  =   "true"
    instance_tenancy      =   "default"
    tags {
      "Terraform"         =   "true"
      "Name"              =   "dev"
      "Owner"             =   "${var.generic_owner}"
    }
}
resource "aws_vpc" "vpc_qat" {
    cidr_block            =   "${var.cidr_qat}"
    enable_classiclink    =   "false"
    enable_dns_support    =   "true"
    enable_dns_hostnames  =   "true"
    instance_tenancy      =   "default"
    tags {
      "Terraform"         =   "true"
      "Name"              =   "qat"
      "Owner"             =   "${var.generic_owner}"
    }
}

#VPC Peering

resource "aws_vpc_peering_connection" "cmn_dev" {
    peer_owner_id = "${var.peer_owner_id}"
    peer_vpc_id = "${aws_vpc.vpc_dev.id}"
    vpc_id = "${aws_vpc.vpc_cmn.id}"
    depends_on = ["aws_vpc.vpc_cmn","aws_vpc.vpc_dev"]
}

resource "aws_vpc_peering_connection" "cmn_qat" {
    peer_owner_id = "${var.peer_owner_id}"
    peer_vpc_id = "${aws_vpc.vpc_qat.id}"
    vpc_id = "${aws_vpc.vpc_cmn.id}"
    depends_on = ["aws_vpc.vpc_cmn","aws_vpc.vpc_qat"]
}
