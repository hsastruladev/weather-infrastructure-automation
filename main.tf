terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0" 
    }
  }
}
provider "docker" {}
resource "docker_image" "weather_img" {
  name = "weather-app:v1"
  build { path = "./weather-app" }
}
resource "docker_container" "weather_container" {
  name  = "weather_prod"
  image = docker_image.weather_img.latest # Changed from image_id to latest
  ports {
    internal = 443
    external = 4000
  }
}