/*
Creating an External Table of VCF data from a Data Lake
*/

CREATE EXTERNAL FILE FORMAT [SynapseVCFFormat] 
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = '\t',
        FIRST_ROW = 50
        )
    )
GO


CREATE EXTERNAL DATA SOURCE [genomicsdatalake01_dfs_core_windows_net]
WITH (
    LOCATION   = 'https://genomicsdatalake01.dfs.core.windows.net/data/'
)
GO


CREATE EXTERNAL TABLE platinum_smallvariants_NA12877 (
	[CHROM] nvarchar(50),
    [POS] bigint,
    [ID] nvarchar(1000),
    [REF] nvarchar(1000),
    [ALT] nvarchar(1000),
    [QUAL] float,
    [FILTER] nvarchar(1000),
    [INFO] nvarchar(4000),
    [FORMAT] nvarchar(1000),
    [SAMPLE] nvarchar(1000)
	)
	WITH (
	LOCATION = 'study_001/NA12877.vcf',
	DATA_SOURCE = [genomicsdatalake01_dfs_core_windows_net],
	FILE_FORMAT = [SynapseVCFFormat]
	)
GO

SELECT TOP 100 * FROM platinum_smallvariants_NA12877
GO

