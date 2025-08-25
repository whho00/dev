variable "env" { type = string }
variable "cluster_name" { type = string }
variable "k8s_version" { type = string } # e.g., "1.33"
variable "node_instance_types" { type = list(string) }
variable "aws_profile" {
  type        = string
  description = "AWS CLI/SSO profile to use"
  default     = "admin"
}


variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

