variable "instance_type" {
  default = "t3.medium"
}

variable "ami_id" {
  description = "Amazon Linux 2023"
  default     = "ami-0f88e80871fd81e91"
}

variable "key_name" {
  default = "Primary"
}

variable "instance_name" {
  default = "Yii 2 App"
}
