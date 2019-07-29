# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

variable "tag1" {}
variable "tag2" {}

# Using lightsail instances
resource "aws_lightsail_instance" "managers" {
  count = 3
  name              = "ala_swarm_manager${count.index}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "medium_2_0"
  key_pair_name     = "id_rsa"
  tags = {
    role = "manager",
    Area = "${var.tag1}"
    Project = "${var.tag2}"
  }
}

resource "aws_lightsail_instance" "workers" {
  count = 3
  name              = "ala_swarm_worker${count.index}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "large_2_0"
  key_pair_name     = "id_rsa"
  tags = {
    Area = "${var.tag1}"
    Project = "${var.tag2}"
  }
}
