resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  availability_zone       = var.availability_zone
  cidr_block              = var.cidr_block
  tags = merge(var.common_tags, {
    Name = "${var.name}-subnet-priv"
    Tier = "private"
  })
}