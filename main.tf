resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.accepter_vpc_id
  vpc_id      = var.requester_vpc_id
  auto_accept = var.auto_accept

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_peering_connection_accepter" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = var.auto_accept

  tags = {
    Name = var.name
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

}


data "aws_route_tables" "requester" {
  vpc_id = var.requester_vpc_id
}

data "aws_route_tables" "accepter" {
  vpc_id = var.accepter_vpc_id
}

resource "aws_route" "requester_route" {
  for_each                  = { for rt in data.aws_route_tables.requester.ids : rt => rt }
  route_table_id            = each.value
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter_route" {
  for_each                  = { for rt in data.aws_route_tables.accepter.ids : rt => rt }
  route_table_id            = each.value
  destination_cidr_block    = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
