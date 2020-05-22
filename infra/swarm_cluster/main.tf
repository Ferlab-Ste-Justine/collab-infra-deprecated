resource "null_resource" "elasticsearch_swarm_setup" {
  triggers = {
    cluster_instance_ids = join(",", var.elasticsearch_ips)
  }

  connection {
    host        = var.bastion_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.key_pair.private_key
  }

  provisioner "file" {
    source      = "${path.module}/elasticsearch_nodes.yml"
    destination = "/home/ubuntu/elasticsearch_nodes.yml"
  }

  provisioner "file" {
    content     = templatefile(
      "${path.module}/inventory", 
      {
         swarm_manager_ip = var.swarm_manager_ip, 
         elasticsearch_ips = var.elasticsearch_ips 
      }
    )
    destination = "/home/ubuntu/inventory"
  }

  provisioner "remote-exec" {
      inline = [
          "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /home/ubuntu/elasticsearch_nodes.yml --private-key=/home/ubuntu/.ssh/id_rsa -u ubuntu -i /home/ubuntu/inventory"
      ]
  }
}


