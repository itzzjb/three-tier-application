terraform {
  # we are going to remote state file stored in amazon s3 instead of local state file
  # we need to use the backend block for that
  backend "s3" {
    bucket = "itzzjb-terraform-bucket"
    region = "us-east-2"
    key = "key/terraform.tfstate" # name of the file that need to be created 
    # key/ is just a directory inside the s3 bucket
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}