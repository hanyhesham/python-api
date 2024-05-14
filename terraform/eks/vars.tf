variable "region" {
  type    = string
  default = "us-east-2"
}

variable "eks_name" {
  type    = string
  default = "dev"
}

variable "eks_node_type" {
  type    = string
  default = "t3.medium"
}

variable "eks_node_name" {
  type    = string
  default = "default-worker"
}

variable "eks_node_disk_type" {
  type    = string
  default = "gp2"
}

variable "eks_cluster_version" {
  type    = string
  default = "1.29"
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}