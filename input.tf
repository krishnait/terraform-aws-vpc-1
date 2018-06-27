variable "name" {
  default     = "mediapop/vpc/aws"
  description = "The name of the VPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "subnets" {
  default     = 1
  description = "The number of subnets."
}
