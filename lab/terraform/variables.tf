variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_vpcname" {
  type = string
}

variable "aws_subnetname" {
  type = string
}

variable "aws_igwname" {
  type = string
}

variable "aws_ami_ubuntu_usw1" { type = string }
variable "aws_ami_ubuntu_euw1" { type = string }

variable "aws_itype" {
  type = string
}

variable "aws_public_ip" {
  type = bool
}

variable "aws_privkey_path" {
  type = string
}

variable "aws_pubkey_path" {
  type = string
}

variable "aws_secgroupname" {
  type = string
}

# variable "num" {
#   type = number
# }
#
# variable "positive_num" {
#   type = number
#   validation {
#     condition     = var.positive_num > 0
#     error_message = "Variable \"positive_num\" must be strictly greater than 0."
#   }
# }
