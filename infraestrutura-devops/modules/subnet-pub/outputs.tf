output "subnet_id" { value = aws_subnet.this.id }
output "subnet_arn" { value = aws_subnet.this.arn }
output "az"         { value = aws_subnet.this.availability_zone }
output "cidr_block" { value = aws_subnet.this.cidr_block }