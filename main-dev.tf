terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"  # Pointing to the exposed TCP port of Docker daemon
}

resource "docker_network" "dev_network" {
  name = "dev_network"
}

resource "docker_container" "node_container" {
  name  = "nodejs_dev"
  image = "node:latest"
  command = ["node", "your-app.js"]  # Adjust with your specific command
  networks = [docker_network.dev_network.name]
}


resource "docker_container" "python_container" {
  name     = "python_dev"
  image    = "python:latest"
  command  = ["tail", "-f", "/dev/null"]  # Changed to a list of strings
  networks = [docker_network.dev_network.name]  # Use networks instead of networks_advanced
}

resource "docker_container" "mysql_container" {
  name  = "mysql_dev"
  image = "mysql:latest"
  env = [
    "MYSQL_ROOT_PASSWORD=root",
    "MYSQL_DATABASE=devdb"
  ]
  networks = [docker_network.dev_network.name]  # Use networks instead of networks_advanced
}
