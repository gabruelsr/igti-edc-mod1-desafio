resource "aws_glue_job" "convert" {
  name     = "igti-edc-csv-parquet-desafio"
  role_arn = aws_iam_role.glue.arn

  command {
    script_location = "s3://${aws_s3_bucket.desafio.bucket}/support-zone/glue-scripts/glue_job_csv_to_parquet.py"
  }
}