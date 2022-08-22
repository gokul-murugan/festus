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

}