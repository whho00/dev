terraform {
  backend "s3" {
    bucket       = "geo-terrform-dev"
    key          = "eks/dev/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}

