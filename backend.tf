terraform {
  backend "s3" {
    bucket         = "your-tfstate-bucket"
    key            = "eks/dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "your-tf-locks"
    encrypt        = true
  }
}

