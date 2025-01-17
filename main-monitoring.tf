# main-monitoring.tf
provider "docker" {
  alias = "monitoring"
  host  = "tcp://127.0.0.1:2375"  # Using 127.0.0.1 instead of localhost
}

resource "docker_network" "monitoring" {
  name = "monitoring"
}

resource "docker_container" "prometheus" {
  provider = docker.monitoring
  name     = "prometheus"
  image    = "prom/prometheus:latest"

  ports {
    internal = 9090
    external = 9090
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}

resource "docker_container" "grafana" {
  provider = docker.monitoring
  name     = "grafana"
  image    = "grafana/grafana:latest"

  ports {
    internal = 3000
    external = 3000
  }

  networks_advanced {
    name = docker_network.monitoring.name
  }
}
