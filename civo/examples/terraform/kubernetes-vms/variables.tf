variable "civo_token" {
  type = string
}

variable "civo_region" {
  type = string
}

variable "ssh_key_pub" {
  type = string
}

variable "ssh_key_private" {
  description = "Private key for instance ssh"
  type        = string
}
