provider "aws" {
  region  = "ap-southeast-1"
  version = "~> 1.23.0"
}

module "key" {
  source = "mediapop/key/aws"
}

module "ami" {
  source       = "devops-workflow/ami-ids/aws"
  distribution = "ubuntu"
  version      = "0.0.2"
}

module "vpc" {
  source = "../../"
}

resource "aws_security_group" "forwarder" {
  vpc_id = "${module.vpc.id}"

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  subnet_id              = "${module.vpc.subnets[0]}"
  ami                    = "${module.ami.ami_id}"
  vpc_security_group_ids = ["${aws_security_group.forwarder.id}"]
  instance_type          = "t2.nano"
  key_name               = "${module.key.name}"
}
