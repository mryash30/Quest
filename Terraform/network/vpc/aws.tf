terraform {
  backend "s3" {
    bucket  = "infra-statefile"
    key     = "network-services/main.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "yash"
  }
}
