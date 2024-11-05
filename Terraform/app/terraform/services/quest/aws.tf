terraform {
  backend "s3" {
    bucket  = "infra-statefile"
    key     = "app-services/ecs/service/main.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

data "terraform_remote_state" "load_balancer" {
  backend   = "s3"
  workspace = local.workspace_common["environment"]

  config = {
    bucket  = "infra-statefile"
    encrypt = true
    key     = "shared-services/ec2/load-balancer/main.tfstate"
    region  = "us-east-1"
  }
}

data "terraform_remote_state" "ecs_cluster" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket  = "infra-statefile"
    encrypt = true
    key     = "app-services/ecs/cluster/main.tfstate"
    region  = "us-east-1"
  }
}

data "terraform_remote_state" "iam_role" {
  backend   = "s3"
  workspace = local.workspace_common["environment"]

  config = {
    bucket  = "infra-statefile"
    encrypt = true
    key     = "shared-services/iam/main.tfstate"
    region  = "us-east-1"
  }
}

data "terraform_remote_state" "ecr" {
  backend   = "s3"
  workspace = local.workspace_common["environment"]

  config = {
    bucket  = "infra-statefile"
    encrypt = true
    key     = "shared-services/ecs/ecr/main.tfstate"
    region  = "us-east-1"
  }
}

data "terraform_remote_state" "netwoking" {
  backend   = "s3"
  workspace = local.workspace_common["environment"]

  config = {
    bucket  = "infra-statefile"
    encrypt = true
    key     = "network-services/main.tfstate"
    region  = "us-east-1"
  }
}

