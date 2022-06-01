/*
Creating an External Table of GATK VCF data from a Public Data Lake
*/


-- DROP EXTERNAL FILE FORMAT [SynapseVCFFormat] 
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseVCFFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseVCFFormat] 
	WITH (
        FORMAT_TYPE = DELIMITEDTEXT,
        DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec',
        FORMAT_OPTIONS (
            FIELD_TERMINATOR = '\t',
            FIRST_ROW = 2
            --189
            )
        )
GO


-- CREATE MASTER KEY ENCRYPTION BY PASSWORD = '23987hxJ#KL95234nl0zBe';
-- GO

-- DROP DATABASE SCOPED CREDENTIAL [GATKTESTDATA_SAS]
CREATE DATABASE SCOPED CREDENTIAL [GATKTESTDATA_SAS]
WITH IDENTITY='SHARED ACCESS SIGNATURE',
SECRET = 'sv=2020-04-08&si=prod&sr=c&sig=fzLts1Q2vKjuvR7g50vE4HteEHBxTcJbNvf%2FZCeDMO4%3D'
GO


-- DROP EXTERNAL DATA SOURCE [datasetgatktestdata_blob_core_windows_net] 
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'datasetgatktestdata_blob_core_windows_net')
	CREATE EXTERNAL DATA SOURCE [datasetgatktestdata_blob_core_windows_net]
	WITH (
		LOCATION   = 'https://datasetgatktestdata.blob.core.windows.net/dataset',
        CREDENTIAL = GATKTESTDATA_SAS
	)
GO


-- DROP EXTERNAL TABLE gatk_platinum_trio
CREATE EXTERNAL TABLE gatk_platinum_trio (
	[CHROM] varchar(50),
	[POS] bigint,
	[ID] varchar(1000),
	[REF] varchar(1000),
	[ALT] varchar(1000),
	[QUAL] float,
	[FILTER] varchar(1000),
    [FORMAT] varchar(1000)
	)
	WITH (
	LOCATION = 'wgs_vcf/PlatinumTrio_b37/PlatinumTrio_b37.vcf.gz',
	DATA_SOURCE = [datasetgatktestdata_blob_core_windows_net],
	FILE_FORMAT = [SynapseVCFFormat]
	)
GO

SELECT TOP 100 * FROM gatk_platinum_trio
GO

