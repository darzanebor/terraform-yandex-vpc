variable "name" {
  default = null
  description = " (Optional) Name of the network. Provided by the client when the network is created."
}

variable "folder_id" {
  default = null
  description = "(Optional) ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used."
}

variable "vpc_description" {
  default = null
  description = "(Optional) An optional description of this resource. Provide this property when you create the resource."
}


variable "vpc_labels" {
  default = {}
  description = "(Optional) Labels to apply to this network. A list of key/value pairs."
}

variable "vpc_subnets" {
  default = []
  description = "(Required) Subnets for creation in VPC"
}

variable "default_security_group_ingress" {
  default = []
  description = "(Optional) - A list of ingress rules to create with default security group."
}

variable "default_security_group_egress" {
  default = []
  description = "(Optional) - A list of egress rules to create with default security group."
}

variable "create_default_security_group" {
  default = false
  description = "(Optional) - Create default security group."
}

variable "create_custom_route_table" {
  default = false
  description = "(Optional) - Create custom route table."
}

variable "custome_route_table_routes" {
  default = []
  description = "(Optional) - Create custom route table routes."
}
