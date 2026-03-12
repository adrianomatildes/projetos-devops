variable "name"               { type = string }
variable "cluster_name"       { type = string }
variable "node_group_name"    { type = string }
variable "eks_version"        { 
  type = string  
  default = "1.30" 
}

variable "subnet_ids"         { type = list(string) }       # públicas + privadas
variable "node_subnet_ids"    { type = list(string) }       # recomendadas privadas

variable "endpoint_public"    { 
  type = bool 
  default = true 
}
variable "endpoint_private"   { 
  type = bool 
  default = false 
}

variable "desired_size"       { 
  type = number 
  default = 2 
}
variable "min_size"           { 
  type = number 
  default = 1 
}
variable "max_size"           { 
  type = number 
  default = 3 
}

variable "ami_type"           { 
  type = string  
  default = "AL2_x86_64" 
}
variable "capacity_type"      { 
  type = string  
  default = "ON_DEMAND" 
}
variable "disk_size"          { 
  type = number  
  default = 20 
}
variable "instance_types"     { 
  type = list(string) 
  default = ["t3.medium"] 
}

variable "common_tags"        { 
  type = map(string) 
  default = {} 
}