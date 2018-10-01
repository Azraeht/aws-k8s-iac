variable "region" {}
variable "shared_credentials_file" {}
variable "profile" {}
variable "key_name" {}
variable "amis" {
  type = "map"
}

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.profile}"
}

resource "aws_instance" "controlpane" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"  
  tags {
    Name = "controlpane"
  }
}
resource "aws_instance" "node1" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"  
  tags {
    Name = "node"
  }
}

resource "aws_instance" "node2" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"  
  tags {
    Name = "node"
  }
}