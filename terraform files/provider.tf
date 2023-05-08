terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.60.0"
    }
  }

  backend "s3" {
    bucket         = "jackyzhoubucketforterraform1"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "c41"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

