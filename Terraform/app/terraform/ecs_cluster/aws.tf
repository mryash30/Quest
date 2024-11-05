terraform {
  backend "s3" {
    bucket  = "infra-statefile"
    key     = "app-services/ecs/cluster/main.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "yash"
  }
}
