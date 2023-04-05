variable "subnet" {
  type        = list(string)
  description = "provide the private subnets"
  default     = ["subnet-08bf1c51696d7c770", "subnet-0a0e56c134246de22", "subnet-0fd635ccde079e169", "subnet-03423bedcf96dcfc9", "subnet-08bd4f7ccba553197", "subnet-0681a3d7a913bf82c"]
}

variable "pg-name" {
  description = "elasticcache name"
  type        = string
  default     = "test-pg-v1"
}

variable "family-ec-name" {
  description = "mention elastic cache family name"
  type        = string
  default     = "redis7"
}

variable "cluster-parameter" {
  description = "list of EC parameter"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "vpc-id" {
  description = "specify vpc-id"
  default     = "vpc-06ad2411ba3f899bd"
}

variable "ports" {
  description = "open the port required for EC"
  type        = list(number)
  default     = [22, 3306]
}

variable "cidrs-block" {
  type    = list(string)
  default = ["103.109.13.50/32"]
}

variable "egress-ports" {
  description = "open the port required for EC"
  type        = list(number)
  default     = [0]
}

variable "egress-cidrs-block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cloud-watch-ec-name" {
  description = "name of cloud watch log name"
  type        = string
  default     = "Yada"
}

variable "kms-key" {
  description = "mention arn of kms key"
  type        = string
  default     = "none"
}

variable "retains-days" {
  description = "mention the number of days"
  type        = number
  default     = 1
}

variable "cloud-watch-ec-eng-name" {
  description = "name of cloud watch log name"
  type        = string
  default     = "eng-log"
}

variable "clsuter-id" {
  description = "mention clsuter name"
  type        = string
  default     = "mycluster"
}

variable "engine-name" {
  description = "mention clsuter engine name"
  type        = string
  default     = "redis"
}

variable "cluster-node-type" {
  description = "mention clsuter node type"
  type        = string
  default     = "cache.t3.micro"
}

variable "cluster-cache-node" {
  description = "mention number ofclsuter node "
  type        = number
  default     = 1
}

variable "cluster-port" {
  description = "mention cluster port number "
  type        = number
  default     = 6379
}

variable "apply-immediately" {
  description = "Whether any database modifications are applied immediately, or during the next maintenance window. Default is false"
  type        = bool
  default     = true
}
