variable "name"           { type = string }
variable "subnet_id"      { type = string }
variable "allocation_id"  { type = string }
variable "common_tags"    { 
  type = map(string) 
  default = {} 
}