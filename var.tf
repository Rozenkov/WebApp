variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "USER" {
  default = "ec2-user"
}

variable "PRIVATE_KEY" {
  default = "terra"
}

variable "PUBLIC_KEY" {
  default = "terra.pub"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0df2a11dd1fe1f8e3"
    us-east-2 = "ami-02bf8ce06a8ed6092"
  }
}