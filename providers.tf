terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.50" }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = "payments-platform"
      Environment = var.env
      IaC         = "terraform"
    }
  }
}


