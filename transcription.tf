terraform {
  required_providers {
    google = {
      source = "google"
    }
  }
}

variable "project" {
  type    = string
  default = "orthocal-1d1b9"
}

variable "zone" {
  type    = string
  default = "us-east4-c"
}

provider "google" {
  project = var.project
  zone    = var.zone
}

resource "google_compute_instance" "transcription" {
  name         = "transcription"
  machine_type = "n1-standard-2"

  boot_disk {
    initialize_params {
      image = "whisperx"
      size  = 50
    }
  }

  guest_accelerator {
    type  = "nvidia-tesla-t4"
    count = 1
  }

  scheduling {
    # This is required when using an accelerator
    on_host_maintenance = "TERMINATE"
  }

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external ip address
    }
  }
}
