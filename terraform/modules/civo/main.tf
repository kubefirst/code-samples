terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}


provider "civo" {
  region = var.civo_cloud_region
  token = var.civo_token
}
module "kubefirst_vm" {
  source = "github.com/kubefirst/code-samples//terraform/modules/civo/kubefirst-vm?ref=main"

  name   = "kubefirst-vm"
  script = local.startup_script
  // Local path to public key on the user who has claimed this module's system
  ssh_public_key = var.ssh_key_pub
}