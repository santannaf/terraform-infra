output "vpc_id" {
  value = aws_vpc.new-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}

output "security_group" {
  value = aws_security_group.sg.id
}

output "network_interface" {
 value = aws_network_interface.new-network-interface[*].id 
}