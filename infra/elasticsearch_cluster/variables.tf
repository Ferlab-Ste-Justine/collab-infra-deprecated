variable "amount" {
    description = "Number of instances"
    type = string
}

variable "network" {
    description = "Network"
    type = any
}

variable "key_pair" {
    description = "SSh key pair"
    type = any
}

variable "flavor" {
    description = "VM flavor"
    type = any
}

variable "image" {
    description = "VM image"
    type = any
}