resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.cidr_block
    nat_gateway_id = var.nat_gateway_id
  }

  tags = merge(var.common_tags, {
    Name = "${var.name}-rtpriv"
  })
}
