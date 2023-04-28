
variable "client_count" {
  description = "The number of VPN clients"
  default     = 10
}

variable "vpn_subnet" {
  description = "The VPN subnet in CIDR notation"
  default     = "10.0.0.0/24"
}
