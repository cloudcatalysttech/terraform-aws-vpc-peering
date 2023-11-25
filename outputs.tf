output "vpc_peering_connection_id" {
  description = "The ID of the VPC Peering Connection"
  value       = aws_vpc_peering_connection.this.id
}

output "requester_vpc_id" {
  description = "The ID of the requester VPC"
  value       = aws_vpc.requester.id # Replace with your actual VPC resource
}

output "accepter_vpc_id" {
  description = "The ID of the accepter VPC"
  value       = aws_vpc.accepter.id # Replace with your actual VPC resource
}

output "requester_vpc_cidr_block" {
  description = "The CIDR block of the requester VPC"
  value       = aws_vpc.requester.cidr_block
}

output "accepter_vpc_cidr_block" {
  description = "The CIDR block of the accepter VPC"
  value       = aws_vpc.accepter.cidr_block
}

output "requester_route_table_id" {
  description = "The ID of the requester VPC's route table"
  value       = aws_route_table.requester.id
}

output "accepter_route_table_id" {
  description = "The ID of the accepter VPC's route table"
  value       = aws_route_table.accepter.id
}