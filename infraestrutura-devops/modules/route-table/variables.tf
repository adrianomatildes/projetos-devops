variable "name"        { type = string }
variable "vpc_id"      { type = string }
variable "gateway_id"  { type = string }
variable "cidr_block"  { 
  type = string  
  default = "0.0.0.0/0" 
}
variable "common_tags" { 
  type = map(string) 
  default = {} 
}