provider "google" {
  project = "optimal-iris-449718-g6"  # Укажите свой проект
  region  = "us-east1"  # Укажите свой регион
}

resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/24"
}

# Правило фаервола для SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.id  # Применяется к вашей сети

  allow {
    protocol = "tcp"
    ports    = ["22"]  # Разрешаем трафик на порт 22
  }

  source_ranges = ["0.0.0.0/0"]  # Разрешаем доступ с любого IP
}
