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
variable "enable_dns_hostnames" { 
  type = bool  
  default = true
}
variable "map_public_ip_on_launch" { 
  type = bool  
  default = true
}
variable "common_tags" {
  type = map(string)
  default = {}
}