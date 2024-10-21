terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
      kubernetes = {
        source  = "hashicorp/kubernetes"
        version = "2.16.0"
      }
      kubectl = {
        source  = "gavinbunney/kubectl"
        version = "~>1.14"
      }
    }
}
provider "aws" {
  region = var.region
}