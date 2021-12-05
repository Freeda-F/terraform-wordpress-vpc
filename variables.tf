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
  default = "t2.micro"
}

variable "key" {
  default = "ohio-vpc"
}

variable "access_key" {

  default = "enter access-keyID here"
  
}

variable "secret_key" {

  default = "enter secret-key here"
  
}