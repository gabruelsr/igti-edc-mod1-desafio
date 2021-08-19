
# Nome do provedor
provider "aws" {
  # Parâmetros
  region = var.region
}

# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "terraform-state-gabruelsr-657791235811"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
} 