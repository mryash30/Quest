terraform {
  backend "s3" {
    bucket  = "infra-statefile"
    key     = "shared-services/ec2/load-balancer/main.tfstate"
    region  = "us-east-1"
    encrypt = true
    # profile = "yash"
  }
}
