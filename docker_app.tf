# Provider Configuration for Docker
provider "docker" {}

# NGINX Container
resource "docker_container" "nginx" {
  name  = "nginx_web"
  image = "nginx:latest"
  ports {
    internal = 80
    external = 8080
  }
}

# Node.js Container
resource "docker_container" "nodejs" {
  name  = "nodejs_app"
  image = "node:latest"
  ports {
    internal = 3000
    external = 3008
  }
}
