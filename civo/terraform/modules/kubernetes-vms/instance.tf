resource "random_string" "random" {
  length           = 3
  special          = false
}

resource "civo_ssh_key" "this" {
  name       = "${var.name}-${random_string.random.result}"
  public_key = var.ssh_public_key
}
 
resource "civo_instance" "this" {
  hostname           = var.name
  size               = element(data.civo_size.large.sizes, 0).name
  disk_image         = element(data.civo_disk_image.ubuntu.diskimages, 0).id
  initial_user       = "root"
  public_ip_required = "create"
  reverse_dns        = var.name
  script             = var.script
  sshkey_id          = civo_ssh_key.this.id
  region             = var.civo_region
  timeouts {
    create = "5m"
  }
}
