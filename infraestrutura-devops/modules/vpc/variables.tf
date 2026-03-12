variable "name" { 
  type = string
}
variable "cidr_block" { 
  type = string
}
variable "enable_dns_hostnames" { 
  type = bool  
  default = true
}
variable "enable_dns_support" { 
  type = bool  
  default = true
}
variable "common_tags" {
  type = map(string)
  default = {}
}