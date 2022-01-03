variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "~/.ssh/mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/mykey.pub"
}

variable "instance_type" {
  default = "t3.nano"
  # Free Tier Eligible 
  # default = "t2.micro"
}
