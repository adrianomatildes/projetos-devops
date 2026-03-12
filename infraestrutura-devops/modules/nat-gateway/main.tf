resource "aws_nat_gateway" "this" {
  subnet_id     = var.subnet_id
  allocation_id = var.allocation_id

  tags = merge(var.common_tags, {
    Name = "${var.name}-nat"
  })
}