variable "region" {
  type = string
  description = "Provide AWS region"
}

variable "key_name" {
    type = string
    description = "Provide EC2 keypair name" 
}

variable "account" {
  type = string
  description = "Provide Aviatrix Access Account name"
}

variable "region_code" {
  type        = string
  description = "Three letter of region code, EG: us-east-2 -> ue2"
}

variable "transit_cidr" {
  type        = string
  description = "Provide transit VPC CIDR"
}

variable "dev_spoke_cidr" {
  type        = string
  description = "Provide dev spoke VPC CIDR"
}

variable "prd_spoke_cidr" {
  type        = string
  description = "Provide prod spoke VPC CIDR"
}

variable "local_as_number" {
  type = number
  description = "Provide transit ASN number"
}

variable "insane_mode" {
  type = bool
  description = "Is HPE insane mode enabled or not"
}

variable "ha_gw" {
  type = bool
  description = "Enable or disable HA Gateway"
}

variable "instance_size" {
  type = string
  description = "Provide instance side for transit/spoke/test instances"
}

variable "deploy_private_instance" {
  type = bool
  description = "Set to true to deploy private instances"
}

variable "bgp_ecmp" {
  type = bool
  description = "Enable BGP ECMP or not"
  default = true
}

variable "enable_transit_firenet" {
  type = bool
  description = "Enable transit firenet or not"
  default = true
}

variable "enable_segmentation" {
  type = bool
  description = "Enable network domain segmentation or not"
  default = false
}

variable "enable_max_performance" {
  type = bool
  default = false
}