variable "region" {
    description = "Openstack region"
    type = string
}

variable "tenant_id" {
    description = "Openstack tenant id"
    type = string
}

variable "application_credential_id" {
    description = "Openstack application credential id"
    type = string
}

variable "application_credential_secret" {
    description = "Openstack application credential secret"
    type = string
}

variable "auth_url" {
    description = "Openstack Keystone auth url"
    type = string
}