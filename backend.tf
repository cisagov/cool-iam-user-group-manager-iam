terraform {
  backend "s3" {
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    key            = "cool-iam-user-group-manager-iam/terraform.tfstate"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
  }
}
