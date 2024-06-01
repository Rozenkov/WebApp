terraform {
  backend "s3" {
    bucket = "terra-s3bucket"
    key    = "terra-state"
    region = "us-east-1"
  }
}