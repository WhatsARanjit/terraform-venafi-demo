# Auth information
variable "tpp_url" {
  description = "Venafi Trust Protection Platform URL (e.g. https://tpp.venafi.example:443/vedsdk)"
}

variable "policy_folder" {
  description = "Zone ID for Venafi Cloud or policy folder for Venafi Platform"
}

# App information
variable "app_name" {
  description = "The name of the NGINX application to deploy"
}

variable "certificate_san" {
  description = "The domain of the certificate SAN"
  default     = "venafidemo.com"
}
