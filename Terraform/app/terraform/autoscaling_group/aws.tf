terraform {
  backend "s3" {
    bucket  = "infra-statefile"
    key     = "app-services/autoscaling-group/main.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
