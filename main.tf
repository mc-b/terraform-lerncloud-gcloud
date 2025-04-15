

# Ubuntu 24.04 LTS

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2404-lts-amd64"
  project = "ubuntu-os-cloud"
}

# Vorhandenes default Network verwenden

data "google_compute_network" "default" {
  name = "default"
}

# Vollzugriff nur für eigene IP

resource "google_compute_firewall" "allow_all_for_my_ip" {
  name    = "${var.module}-admin-access"
network = data.google_compute_network.default.name


  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["${chomp(data.http.myip.response_body)}/32"]
}

# Öffentlich zugängliche Ports (z.B. 22, 80, 443, 16443)

resource "google_compute_firewall" "public_ports" {
  name    = "${var.module}-public"
network = data.google_compute_network.default.name


  allow {
    protocol = "tcp"
    ports    = var.ports[*]
  }

  allow {
    protocol = "udp"
    ports    = var.ports[*]
  }

  source_ranges = [
    "0.0.0.0/0",         # Öffnet Ports für das Internet
    "172.0.0.0/8"        # Interne Netzwerke
  ]
}

# VMs

resource "google_compute_instance" "vm" {
  for_each = var.machines

  name         = each.value.hostname
  machine_type = lookup(var.instance_type, coalesce(each.value.memory, var.memory))

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = coalesce(each.value.storage, var.storage)
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {}
  }

    metadata = {
      user-data = each.value.userdata
    }

  tags = [var.module]
}
