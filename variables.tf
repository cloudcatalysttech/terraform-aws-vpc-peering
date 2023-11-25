variable "requester_vpc_id" {
  description = "The ID of the requester VPC"
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the accepter VPC"
  type        = string
}

variable "auto_accept" {
  description = "Automatically accept the peering request"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name tag for the VPC peering resources"
  type        = string
  default     = "vpc-peering" # This provides a default value, but you can override it
}

variable "requester_vpc_cidr" {
  description = "The CIDR block of the requester VPC"
  type        = string
}

variable "accepter_vpc_cidr" {
  description = "The CIDR block of the accepter VPC"
  type        = string
}

variable "requester_role_arn" {
  description = "ARN of the IAM role for the requester provider"
  type        = string
}

variable "accepter_role_arn" {
  description = "ARN of the IAM role for the accepter provider"
  type        = string
}