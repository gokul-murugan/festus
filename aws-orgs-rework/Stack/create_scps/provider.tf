provider "aws" {
  region  = "us-east-1"
  profile = "orgs"
}

terraform {

  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket  = "gokul-test-tf-bucket"
    key     = "service-control-policies/scp.tfstate"
    region  = "us-east-1"
    profile = "orgs"
  }

}