# HCL - (Hashicorp Configuration Language) - Linguagem declarativa

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

resource "aws_s3_bucket_object" "raw_data" {
  for_each = fileset("../microdados_educacao_basica_2020", "*")
  bucket = aws_s3_bucket.desafio.id
  key    = "gabruelsr-igti-desafio-mod1/raw_zone/raw_data/${each.key}"
  source = "../microdados_educacao_basica_2020/${each.key}"
}