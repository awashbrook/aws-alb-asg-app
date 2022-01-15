variable "AWS_REGION" {
  default = "eu-west-1"
}
# At least 2
variable "number_of_azs" {
  description = "At least 2 "
  default     = 2
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
