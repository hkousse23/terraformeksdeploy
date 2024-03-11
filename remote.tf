data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "modulebuck" #change the name of the bucket#
    key = "statefiles/terraform.tfstate"
    region = var.region
  }
}
