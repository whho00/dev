variable "env"            { type = string }
variable "region"         { type = string }
variable "cluster_name"   { type = string }
variable "k8s_version"    { type = string }  # e.g., "1.33"
variable "node_instance_types" { type = list(string) }

