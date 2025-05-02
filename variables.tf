
variable "machines" {
  type = map(object({
    hostname    = string
    description = optional(string)
    userdata    = string
    memory      = optional(number)
    cores       = optional(number)
    storage     = optional(number)
  }))
  default     = {}
  description = "Definition der Maschinen"
}

variable "region" {
  default     = "europe-west1"
  description = "Region"
}

variable "zone" {
  default     = "europe-west1-b"
  description = "Zone"
}

variable "module" {
  default     = "base"
  description = "Modulname: wird auch für Tags genutzt"
}

variable "description" {
  default     = "Beschreibung VM"
  description = "Beschreibung VM"
}

variable "memory" {
  default     = 2
  description = "Memory in GB"
}

variable "cores" {
  description = "Anzahl CPUs"
  type        = number
  default     = 1
}

variable "storage" {
  default     = 32
  description = "Disk Size in GB"
}

variable "ports" {
  type        = list(string)
  default     = ["22", "80"]
  description = "Firewall Ports"
}

variable "userdata" {
  default     = "cloud-init.yaml"
  description = "Startup Script"
}

variable "url" {
  default = "not used"
}

variable "key" {
  default   = "not used"
  sensitive = true
}

variable "vpn" {
  default = "not used"
}

variable "instance_type" {
  type = map(string)
  default = {
    1  = "e2-micro"
    2  = "e2-small"
    4  = "e2-medium"
    6  = "e2-standard-2"    
    8  = "e2-standard-2"
    16 = "e2-standard-4"
    32 = "e2-standard-8"
    64 = "e2-standard-16"
  }
}


