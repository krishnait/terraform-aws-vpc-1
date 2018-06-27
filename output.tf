output "id" {
  value       = "${aws_vpc.vpc.id}"
  description = "The VPC id"
}

output "subnets" {
  value       = "${aws_subnet.subnet.*.id}"
  description = "The VPC subnet ids"
}
