variable "subnets_cidr_block"{
  description = "The CIDR block for the subnet"
  type        = list(string)
  default     = ["192.168.18.0/24", "192.168.19.0/24"]
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "subnet_name" {
  description = "The name to tag the subnet"
  type        = list(string)
  default     = ["raz-subnet-terraform-one","raz-subnet-terraform-two"]
}
variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  type        = string
  default     = "vpc-01b834daa2d67cdaa"
}
variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "routetable_name" {
  description = "The name to tag the route-table"
  type        = string
  default     = "raz-route-table-terraform"
}
variable "bucket_name"{
  description = "The ID of the Main Bucket"
  type        = string
  default     = "raz-bucket"
}

