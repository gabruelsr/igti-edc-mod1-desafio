
# Nome do provedor
provider "aws" {
  # Parâmetros
  region = var.region
}

# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "${aws_s3_bucket.desafio.bucket}"
    key    = "state/terraform/terraform.tfstate"
    region = "us-east-2"
  }
} 