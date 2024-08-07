terraform {
  required_providers {
    civo = {
      source = "civo/civo"
      version = "1.0.45"
    }
  }
}

provider "civo" {
  region = var.civo_region
  token  = var.civo_token
}

module "k1_master_1" {
  source = "github.com/kubefirst/code-samples//civo/terraform/modules/kubernetes-vms?ref=main"

  name   = "k1-master-1"
  script = local.startup_script
  // Local path to public key on the user who has claimed this module's system
  ssh_public_key = var.ssh_key_pub
  civo_region    = var.civo_region
}

module "k1_master_2" {
  source = "github.com/kubefirst/code-samples//civo/terraform/modules/kubernetes-vms?ref=main"

  name   = "k1-master-2"
  script = local.startup_script
  // Local path to public key on the user who has claimed this module's system
  ssh_public_key = var.ssh_key_pub
  civo_region    = var.civo_region
}

module "k1_master_3" {
  source = "github.com/kubefirst/code-samples//civo/terraform/modules/kubernetes-vms?ref=main"

  name   = "k1-master-3"
  script = local.startup_script
  // Local path to public key on the user who has claimed this module's system
  ssh_public_key = var.ssh_key_pub
  civo_region    = var.civo_region
}

resource "null_resource" "sleep" {
  depends_on = [ module.k1_master_1, module.k1_master_2, module.k1_master_3 ]

 provisioner "local-exec" {
    command = "/bin/sleep 10"
  }
}

resource "null_resource" "update_local_ssh" {
  depends_on = [ null_resource.sleep ]

 provisioner "local-exec" {
    command = "/bin/bash ./scripts/update-local-ssh.sh"
  }
}

resource "null_resource" "update_etc_hosts" {
  depends_on = [ null_resource.sleep ]

 provisioner "local-exec" {
    command = "/bin/bash ./scripts/update-etc-hosts.sh"
  }
}
