variable "ami_us_east" {
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2 - US East (N. Virginia)
}

variable "ami_ap_south" {
  default = "ami-0382ffa63b15fc163" # Amazon Linux 2 - AP South (Mumbai)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name_us_east" {
  default = "my-key-us-east"
}

variable "key_name_ap_south" {
  default = "my-key-ap-south"
}
