variable "name" { 
  type = string
}
variable "vpc_id" {
  type = string
}
variable "cidr_block" { 
  type = string
}
variable "availability_zone" { 
  type = string
}
variable "common_tags" {
  type = map(string)
  default = {}
}