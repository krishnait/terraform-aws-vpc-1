# EC2 instance in the VPC

How to setup a simple EC2 instance in the VPC.

```hcl
module "vpc" {
  source = "../../"
}

data "local_file" "public_key" {
  filename = "~/.ssh/id_rsa.pub"
}

module "ami" {
  source       = "devops-workflow/ami-ids/aws"
  distribution = "ubuntu"
  version      = "0.0.2"
}

resource "aws_security_group" "forwarder" {
  vpc_id = "${module.vpc.id}"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key" {
  public_key = "${var.public_key}"
}

resource "aws_instance" "instance" {
  subnet_id     = "${module.vpc.subnets[0]}"
  ami           = "${module.ami.ami_id}"
  key_name      = "${aws_key_pair.key.key_name}"
  instance_type = "t2.nano"
}
```
