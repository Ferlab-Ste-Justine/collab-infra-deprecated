output "ips" {
    value = [
        for node in openstack_compute_instance_v2.elasticsearch_nodes : node.network.0.fixed_ip_v4
    ]
}

