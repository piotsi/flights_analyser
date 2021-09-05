terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.39"
    }
  }

  required_version = ">= 0.15"
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# provisioner "local-exec" {
#   command = "sleep 120; ansible-playbook -i '${digitalocean_droplet.www-example.ipv4_address}' playbook.yml"
# }

# provisioner "remote-exec" {
#   inline = ["echo 'Hello World'"]

#   connection {
#     type        = "ssh"
#     user        = "root"
#     host        = self.ipv4_address
#     private_key = file(var.ssh_key_private)
#   }
# }