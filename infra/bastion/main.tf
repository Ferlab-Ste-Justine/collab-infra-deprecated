resource "openstack_networking_floatingip_v2" "bastion_ip" {
  pool = var.external_network.name
}

data "template_cloudinit_config" "bastion_config" {
  gzip = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/bastion_cloud_config.yaml", var.key_pair)
  }
}

resource "openstack_compute_instance_v2" "bastion" {
  name            = "bastion"
  image_id        = var.image.id
  flavor_id       = var.flavor.id
  key_pair        = var.key_pair.name
  security_groups = ["default"]
  user_data = data.template_cloudinit_config.bastion_config.rendered

  network {
    name = var.internal_network.name
  }
}

resource "openstack_compute_floatingip_associate_v2" "bastion_ip" {
  floating_ip = openstack_networking_floatingip_v2.bastion_ip.address
  instance_id = openstack_compute_instance_v2.bastion.id
}