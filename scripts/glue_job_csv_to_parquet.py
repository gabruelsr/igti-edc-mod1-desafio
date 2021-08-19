import sys
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

file_list = ['docentes_co.CSV',
 'docentes_nordeste.CSV',
 'docentes_norte.CSV',
 'docentes_sudeste.CSV',
 'docentes_sul.CSV',
 'escolas.CSV',
 'gestor.CSV',
 'matricula_co.CSV',
 'matricula_nordeste.CSV',
 'matricula_norte.CSV',
 'matricula_sudeste.CSV',
 'matricula_sul.CSV',
 'turmas.CSV']

# Ler os dados em CSV no S3
for file in file_list:
    file = (
        spark
        .read
        .format("csv")
        .option("header", True)
        .option("inferSchema", True)
        .option("delimiter", "|")
        .load("s3://gabruelsr-igti-desafio-mod1/raw-zone/raw-data/"+file)
        )
        (# Escrever em parquet de volta no S3
        file
        .write
        .mode("overwrite")
        .format("parquet")
        .save("s3://gabruelsr-igti-desafio-mod1/staging-zone/staging-data/")
        )