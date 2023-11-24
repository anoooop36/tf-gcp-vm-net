provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
  zone    = "us-central1-c"
}


resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = var.net_name
  auto_create_subnetworks = "true"
}

variable "project" {}
variable "credentials" {}

variable "region" {
	default = "us-central1"
}

variable "vm_name" {
  default = "tf-instance-removeit"
}

variable "net_name" {
  default = "tf-network-removeit"
}
