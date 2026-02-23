variable "key_name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "server_name" {
  type    = string
  default = "DevOps-IaC-Server"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}