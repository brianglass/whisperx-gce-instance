variable "project_id" {
  type    = string
  default = "orthocal-1d1b9"
}

variable "zone" {
  type    = string
  default = "us-east4-c"
}

source "googlecompute" "whisperx" {
  image_family        = "whisperx"
  image_name          = "whisperx-{{timestamp}}"
  project_id          = var.project_id
  zone                = var.zone
  source_image_family = "ubuntu-2204-lts"
  disk_size           = 50
  ssh_username        = "packer"
}

build {
  sources = ["source.googlecompute.whisperx"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "install.sh"
  }
}
