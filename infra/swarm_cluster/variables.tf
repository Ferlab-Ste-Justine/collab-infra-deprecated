variable "elasticsearch_ips" {
    description = "Ips of the elasticsearch cluster"
    type = list(string)
}

variable "bastion_ip" {
    description = "Ip of the bastion"
    type = string
}

variable "swarm_manager_ip" {
    description = "Ip of a swarm manage"
    type = string
}

variable "key_pair" {
    description = "SSh key pair"
    type = any
}