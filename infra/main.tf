terraform {
  backend "s3" {
    bucket       = "cloud-demo-terraform-1"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    # Elimina dynamodb_table y añade esta línea:
    use_lockfile = true 
    encrypt      = true
  }
}