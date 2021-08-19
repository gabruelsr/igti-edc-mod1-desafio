# Subir arquivos CSV para o bucket
resource "aws_s3_bucket_object" "raw_data" {
  for_each = fileset("../microdados_educacao_basica_2020", "*")
  bucket   = aws_s3_bucket.desafio.bucket
  acl = "private"
  key      = "raw-zone/raw-data/${each.key}"
  source   = "../microdados_educacao_basica_2020/${each.key}"
  etag = filemd5("../microdados_educacao_basica_2020/${each.key}")
}
