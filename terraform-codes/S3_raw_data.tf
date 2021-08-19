# Subir arquivos CSV para o bucket
resource "aws_s3_bucket_object" "raw_data" {
  for_each = fileset("../microdados_educacao_basica_2020", "*")
  bucket = aws_s3_bucket.desafio.id
  key    = "gabruelsr-igti-desafio-mod1/raw-zone/raw-data/${each.key}"
  source = "../microdados_educacao_basica_2020/${each.key}"
}