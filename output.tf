output "aws_instance" {
  value = [
    aws_instance.app-server[*].id # List of instance IDs
  ]

}
output "aws_vpc" {
  value = aws_vpc.MyVPC
}
output "aws_subnet" {
  value = [
    aws_subnet.public_a,
    aws_subnet.public_b
  ]
}
output "aws_internet_gateway" {
  value = aws_internet_gateway.main
}
output "aws_route_table" {
  value = aws_route_table.public
}
output "aws_route_table_association" {
  value = [
    aws_route_table_association.public_a,
    aws_route_table_association.public_b
  ]
}
output "aws_security_group" {
  value = aws_security_group.vpc
}
