# The backend of which the state file is stored.
terraform {
  backend "s3" {
    region = "eu-west-1"
    key    = "terraform.tfstate"
    bucket = "raz-bucket"
  }
}
