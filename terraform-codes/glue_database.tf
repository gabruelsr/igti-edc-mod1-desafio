
resource "aws_glue_catalog_database" "catalog-desafio" {
  name = "igti-edc-mod1-desafio"
  description = "catalogo de raw data do desafio igti edc mod 1"
  location_uri = "s3://${aws_s3_bucket.desafio.id}/raw-zone/"
}