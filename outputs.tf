output "nginx_certificate" {
  value       = venafi_certificate.nginx.certificate
  description = "The X509 certificate in PEM format"
}

output "nginx_chain" {
  value       = venafi_certificate.nginx.chain
  description = "The trust chain of X509 certificate authority certificates in PEM format concatenated together"
}

output "nginx_private_key_pem" {
  value       = venafi_certificate.nginx.private_key_pem
  description = "The private key in PEM format"
  sensitive   = true
}

output "nginx_address" {
  value       = "https://${docker_container.nginx.hostname}:443"
  description = "HTTPS address of the NGINX app"
}
