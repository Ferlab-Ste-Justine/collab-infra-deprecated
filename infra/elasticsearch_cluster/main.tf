resource "openstack_compute_instance_v2" "elasticsearch_nodes" {
  count           = var.amount
  name            = "elasticsearch_node_${count.index + 1}"
  image_id        = var.image.id
  flavor_id       = var.flavor.id
  key_pair        = var.key_pair.name
  security_groups = ["default"]

  network {
    name = var.network.name
  }
}