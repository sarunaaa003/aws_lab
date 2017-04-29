##########################################################################################
##########################################################################################
#USED ONLY TO CREATE GATEWAY FOR THE WORKING VPC - In this case cmn the working directory is the name of the VPC
##########################################################################################
##########################################################################################
resource "aws_internet_gateway" "IGW" {
    vpc_id = "${terraform_remote_state.infra.output.VPC_CMN_ID}" #replace "VPC_CMN" for relevant VPC's

    tags {
      "Terraform" = "true"
      "Name"      = "${var.environment}_IGW"
      "Owner"     = "${var.generic_owner}"
    }
}

resource "aws_vpc_endpoint" "S3EP_LOCAL_S3" {
  vpc_id          = "${terraform_remote_state.infra.output.VPC_CMN_ID}" #replace "VPC_CMN" for relevant VPC's
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = ["${aws_route_table.RT_LOCAL_PRIVATE.id}","${aws_route_table.RT_LOCAL_PUBLIC.id}"]
}
