# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

variable "tag1" {}
variable "tag2" {}
variable "keypair" {
    default = "id_rsa"
}
variable "qtdman" {
    default = 1
}
variable "qtdwor" {
    default = 4
}

# Using lightsail instances
resource "aws_lightsail_instance" "managers" {
  count = "${var.qtdman}"
  name              = "ala_swarm_manager${count.index}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "medium_2_0"
  key_pair_name     = "${var.keypair}"
  tags = {
    role = "manager",
    Area = "${var.tag1}"
    Project = "${var.tag2}"
  }
}

resource "aws_lightsail_instance" "workers" {
  count = "${var.qtdwor}"
  name              = "ala_swarm_worker${count.index}"
  availability_zone = "us-east-1b"
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "large_2_0"
  key_pair_name     = "${var.keypair}"
  tags = {
    Area = "${var.tag1}"
    Project = "${var.tag2}"
  }
}
