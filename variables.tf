variable "region" {
  default = "us-east-2"
}

variable "cidr_block" {
    default = "172.20.0.0/16"
  
}

variable "project" {
    default = "demo"
  
}

variable "ami" {
  default = "ami-002068ed284fb165b"
  
}

variable "type" {
  default = "t2x.micro"
}

variable "key" {
  default = "ohio-vpc"
}

variable "access_key" {

    default = "Enter accesskey ID here"
  
}

variable "secret_key" {

    default = "Enter secretkey here"
  
}
