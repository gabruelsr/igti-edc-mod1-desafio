# Subir arquivos CSV para o bucket
resource "aws_s3_bucket_object" "raw_data" {
  for_each = fileset("../microdados_educacao_basica_2020", "*")
  bucket   = aws_s3_bucket.desafio.bucket
  key      = "raw_zone/raw_data/${each.key}"
  source   = "../microdados_educacao_basica_2020/${each.key}"
}

resource "aws_s3_bucket_object" "glue_job_script" {
  bucket = aws_s3_bucket.desafio.bucket
  key    = "support_zone/glue-scripts/glue_job_csv_to_parquet.py"
  acl    = "private"
  source = "../scripts/glue_job_csv_to_parquet.py"
  etag   = filemd5("../scripts/glue_job_csv_to_parquet.py")
}