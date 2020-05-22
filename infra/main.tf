resource "openstack_compute_keypair_v2" "admin_keypair" {
  name = "admin_keypair"
}

module "bastion" {
  source = "./bastion"
  external_network = data.openstack_networking_network_v2.external_network
  internal_network = data.openstack_networking_network_v2.network
  key_pair = openstack_compute_keypair_v2.admin_keypair
  flavor = data.openstack_compute_flavor_v2.micro
  image = data.openstack_images_image_v2.ubuntu_bionic
}

module "elasticsearch_cluster" {
  source = "./elasticsearch_cluster"
  amount = 3
  network = data.openstack_networking_network_v2.network
  key_pair = openstack_compute_keypair_v2.admin_keypair
  flavor = data.openstack_compute_flavor_v2.small
  image = data.openstack_images_image_v2.ubuntu_bionic
}

module "swarm_cluster" {
  source = "./swarm_cluster"
  elasticsearch_ips = module.elasticsearch_cluster.ips
  bastion_ip = module.bastion.external_ip
  swarm_manager_ip = var.swarm_manager_ip
  key_pair = openstack_compute_keypair_v2.admin_keypair
}
