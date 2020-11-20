# Setup Venafi target
provider "venafi" {
  url  = var.tpp_url
  zone = var.policy_folder
}

# Pull certificate from Venafi
resource "venafi_certificate" "nginx" {
  common_name = "${var.app_name}.${var.certificate_san}"
  san_dns     = [
    "ubuntu.${var.certificate_san}"
  ]
}

# Setup Docker target
provider "docker" {}

# Stage NGINX docker image for use
resource "docker_image" "nginx" {
  name = "paulternate/ssl-nginx"
}

# Create NGINX container with image and certificate
resource "docker_container" "nginx" {
  name     = upper(var.app_name)
  hostname = "localhost"
  image    = docker_image.nginx.latest
  ports {
    internal = "443"
    external = "443"
    ip       = "0.0.0.0"
  }

  # Inject certificate/key into the NGINX docker container
  upload {
    content = venafi_certificate.nginx.certificate
    file    = "/etc/nginx/ssl/certificate.pem"
  }

  upload {
    content = venafi_certificate.nginx.private_key_pem
    file    = "/etc/nginx/ssl/privatekey.pem"
  }

  upload {
    source = "files/index.html"
    file   = "/var/www/index.html"
  }

  upload {
    source = "files/styles.css"
    file   = "/var/www/styles.css"
  }

  upload {
    source = "files/background.jpg"
    file   = "/var/www/background.jpg"
  }
}
