data "openstack_networking_network_v2" "network" {
  name = "Sainte_Justine_Ferretti_net"
}

data "openstack_networking_network_v2" "external_network" {
  name = "ext-net"
}

data "openstack_compute_flavor_v2" "micro" {
  name = "c1.micro"
}

data "openstack_compute_flavor_v2" "small" {
  name = "c1.small"
}

data "openstack_compute_flavor_v2" "medium" {
  name = "c1.medium"
}

data "openstack_images_image_v2" "ubuntu_bionic" {
  name        = "Ubuntu 18.04 - latest"
  most_recent = true
}