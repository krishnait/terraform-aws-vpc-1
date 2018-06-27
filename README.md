# Terraform VPC

*This terraform module is maintained by [Media Pop](https://www.mediapop.co), a software consultancy. Hire us to solve your DevOps challenges.*

Simplest way of setting up a public VPC.

# Usage


```hcl
module "vpc" {
  source = "mediapop/vpc/aws"
}

resource "aws_instance" "instance" {
  subnet_id = "${module.vpc.subnets[0]}"
  
  // ...
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | Name the VPC. | string | mediapop/aws/vpc | no |
| cidr_block | The CIDR block | string | 10.0.0.0/16 | no |
| subnets | The number of subnets. | number | 1 | no |

## Outputs

| Name | Description | Type |
|------|-------------|:----:|
| id | VPC id | string |
| subnets | The VPC subnet ids | array |

## License

MIT
