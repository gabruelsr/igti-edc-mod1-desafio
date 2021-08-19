import sys
import glob
from pyspark.context import SparkContext
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: ['JOB_NAME']
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Ler os dados em CSV no S3
for file in glob.glob("s3://gabruelsr-igti-desafio-mod1/raw-zone/raw-data/ *.csv"):
    file = (
        spark
        .read
        .format("csv")
        .option("header", True)
        .option("inferSchema", True)
        .option("delimiter", "|")
        .load("s3://gabruelsr-igti-desafio-mod1/raw-zone/raw-data/"+str(file))
        )
        (# Escrever em parquet de volta no S3
        file
        .write
        .mode("overwrite")
        .format("parquet")
        .save("s3://gabruelsr-igti-desafio-mod1/staging-zone/staging-data/"+str(file))
        )