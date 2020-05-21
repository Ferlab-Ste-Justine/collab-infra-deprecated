data "template_cloudinit_config" "elasticsearch_config" {
  gzip = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = file("${path.module}/cloud_config.yaml")
  }
}

resource "openstack_compute_instance_v2" "elasticsearch_nodes" {
  count           = var.amount
  name            = "elasticsearch_node_${count.index + 1}"
  image_id        = var.image.id
  flavor_id       = var.flavor.id
  key_pair        = var.key_pair.name
  security_groups = ["default"]
  user_data = data.template_cloudinit_config.elasticsearch_config.rendered

  network {
    name = var.network.name
  }
}