terraform {
  backend "s3" {
    bucket = "eks-terraform-ez"
    key = "terraform-state/state-file"
    region = "ap-south-1"
    profile = "personal"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "personal"
  region  = "us-west-1"
}

# resource "aws_instance" "app_server" {
#   ami           = "ami-01f87c43e618bf8f0"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }

