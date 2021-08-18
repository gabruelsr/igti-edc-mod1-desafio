# HCL - (Hashicorp Configuration Language) - Linguagem declarativa

# Nome do provedor
provider "aws" {
  # Parâmetros
  region = var.region
}

#recurso "nome do recurso" "nome no terraform"
resource "aws_s3_bucket" "desafio" {
  #parâmetros de configuração do recurso
  bucket = "gabruelsr-igti-desafio-mod1"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "GabruelSR"
    ACC  = "${var.num_conta}"
  }
}

resource "aws_s3_bucket_object" "raw" {
  for_each = fileset("../microdados_educacao_basica_2020", "**/*.csv")

  bucket       = aws_s3_bucket.desafio.id
  key          = each.key
  source       = "${path.module}/content/${each.key}"
  content_type = "csv"
  etag         = filemd5("${path.module}/content/${each.key}")
}