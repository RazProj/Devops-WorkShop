terraform {
  backend "s3" {
    region = "eu-west-1"
    key    = "terraform.tfstate"
    bucket = "raz-bucket"
  }
}

provider "aws" {
  region = "eu-west-1"
}
