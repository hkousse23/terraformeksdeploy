data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "modulebuck"
    key = "statefiles/terraform.tfstate"
    region = "us-east-1"
  }
}
