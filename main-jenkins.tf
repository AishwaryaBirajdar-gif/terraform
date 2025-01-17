
provider "docker" {
  host = "tcp://localhost:2375"
  alias = "jenkins"
}

resource "docker_container" "jenkins" {
  provider = docker.jenkins  # Reference the provider alias here

  name    = "jenkins"
  image   = "jenkins/jenkins:lts"
  ports {
    internal = 8080
    external = 8081  # Changed to 8081
  }
  volumes {
    host_path      = "C:\\Users\\Aishwarya\\jenkins_home"  # Double backslashes
    container_path = "/var/jenkins_home"
  }
}
