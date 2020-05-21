resource "openstack_compute_keypair_v2" "admin_keypair" {
  name = "admin_keypair"
}

resource "openstack_compute_instance_v2" "elasticsearch_nodes" {
  count           = 3
  name            = "elasticsearch_node_${count.index}"
  image_id        = data.openstack_images_image_v2.ubuntu_bionic.id
  flavor_id       = data.openstack_compute_flavor_v2.small.id
  key_pair        = openstack_compute_keypair_v2.admin_keypair.name
  security_groups = ["default"]

  network {
    name = data.openstack_networking_network_v2.network.name
  }
}

resource "openstack_networking_floatingip_v2" "bastion_ip" {
  pool = data.openstack_networking_network_v2.external_network.name
}

data "template_cloudinit_config" "bastion_config" {
  gzip = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/bastion_cloud_config.yaml", openstack_compute_keypair_v2.admin_keypair)
  }
}

resource "openstack_compute_instance_v2" "bastion" {
  name            = "bastion"
  image_id        = data.openstack_images_image_v2.ubuntu_bionic.id
  flavor_id       = data.openstack_compute_flavor_v2.micro.id
  key_pair        = openstack_compute_keypair_v2.admin_keypair.name
  security_groups = ["default"]
  user_data = data.template_cloudinit_config.bastion_config.rendered

  network {
    name = data.openstack_networking_network_v2.network.name
  }
}

resource "openstack_compute_floatingip_associate_v2" "bastion_ip" {
  floating_ip = openstack_networking_floatingip_v2.bastion_ip.address
  instance_id = openstack_compute_instance_v2.bastion.id
}