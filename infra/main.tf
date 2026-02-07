terraform {
  backend "s3" {
    bucket         = "cloud-demo-terraform"  # replace with your bucket name
    key            = "terraform.tfstate"            # path inside bucket
    region         = "eu-west-1"                    # AWS region
    dynamodb_table = "use_lockfile"              # optional for state locking
    encrypt        = true                            # encrypt state at rest
  }
}