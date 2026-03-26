variable "api_key" {
  description = "NetActuate API key (from portal.netactuate.com/account/api)"
  type        = string
  sensitive   = true
}

variable "contract_id" {
  description = "NetActuate billing contract ID"
  type        = string
}

variable "bgp_group_id" {
  description = "NetActuate BGP group ID (pre-configured by NetActuate support)"
  type        = string
}

variable "locations" {
  description = "List of PoP location codes to deploy VMs in (e.g., [\"LAX\", \"FRA\", \"SIN\"])"
  type        = list(string)
}

variable "vm_count_per_location" {
  description = "Number of VMs to create per location"
  type        = number
  default     = 1
}

variable "plan" {
  description = "VM plan (e.g., \"VR1x1x25\", \"VR8x4x50\")"
  type        = string
}

variable "os_image" {
  description = "OS image name"
  type        = string
  default     = "Ubuntu 24.04 LTS (20240423)"
}

variable "hostname_prefix" {
  description = "Prefix for VM hostnames"
  type        = string
}

variable "domain" {
  description = "Domain suffix for VM hostnames"
  type        = string
  default     = "example.com"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file (ignored if ssh_key_id is set)"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_key_id" {
  description = "Existing SSH key ID from NetActuate portal (if set, skips creating a new key)"
  type        = number
  default     = null
}
