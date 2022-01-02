variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0ee02acd56a52998e"
    us-west-2 = "ami-0dd273d94ed0540c0"
    eu-west-1 = "ami-038d7b856fe7557b3"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh/mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}