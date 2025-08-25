
terraform {
  required_version = "~> 1.5"
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 5.50"
#    }
#  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile # IMPORTANT: must be a string, e.g. "admin"
  default_tags {
    tags = {
      Project     = "payments-platform"
      Environment = var.env
      IaC         = "terraform"
    }
  }
}


terraform {
  required_version = "~> 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9"   # allows any >=6.9.x <7.0.0
    }
    tls       = { source = "hashicorp/tls",       version = "~> 4.0" }
    time      = { source = "hashicorp/time",      version = "~> 0.9" }
    null      = { source = "hashicorp/null",      version = "~> 3.0" }
    cloudinit = { source = "hashicorp/cloudinit", version = "~> 2.0" }
  }
}

