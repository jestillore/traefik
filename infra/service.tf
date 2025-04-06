resource "docker_container" "reverse_proxy" {
  name  = "reverse-proxy"
  image = "traefik:v3.3"
  restart = "always"

  command = ["--configFile=/etc/traefik/traefik.yml"]

  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }

  ports {
    internal = 8080
    external = 8080
    protocol = "tcp"
  }

  volumes {
    host_path      = abspath("${path.module}/../traefik.yml")
    container_path = "/etc/traefik/traefik.yml"
  }

  volumes {
    host_path      = abspath("${path.module}/../dynamic.yml")
    container_path = "/etc/traefik/dynamic.yml"
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  networks_advanced {
    name = "services"
  }
}
