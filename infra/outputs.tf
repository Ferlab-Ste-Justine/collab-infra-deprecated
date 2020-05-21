output "admin_ssh" {
    value = {
        public_key = openstack_compute_keypair_v2.admin_keypair.public_key
        private_key = openstack_compute_keypair_v2.admin_keypair.private_key
    }
}

output "bastion_external_ip" {
    value = module.bastion.external_ip
}