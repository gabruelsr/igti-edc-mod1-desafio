
# Nome do provedor
provider "aws" {
  # Parâmetros
  region = var.region
}

# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "gabruelsr-igti-desafio-mod1"
    key    = "state/terraform/terraform.tfstate"
    region = "us-east-2"
  }
}