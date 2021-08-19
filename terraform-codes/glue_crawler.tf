resource "aws_glue_crawler" "desafio" {
  database_name = aws_glue_catalog_database.catalog-desafio.name
  name          = "glue-crawler-desafio-igti-mod1"
  role          = aws_iam_role.glue.arn

  s3_target {
    path = "s3://${aws_s3_bucket.desafio.bucket}/staging-zone/"
  }

  configuration = <<EOF
{
   "Version": 1.0,
   "Grouping": {
      "TableGroupingPolicy": "CombineCompatibleSchemas" }
}
EOF

  tags = {
    Name = "GabruelSR",
    ACC  = "${var.num_conta}"
  }
}