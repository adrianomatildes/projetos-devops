output "vpc_id"    { value = aws_vpc.this.id }
output "vpc_arn"   { value = aws_vpc.this.arn }
output "cidr_block"{ value = aws_vpc.this.cidr_block }