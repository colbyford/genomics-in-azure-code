/*
Read VCF Data from a Data Lake using OPENROWSET
*/
SELECT TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://genomicsdatalake01.dfs.core.windows.net/data/study_001/NA12877.vcf',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '\t',
        FIELDQUOTE = '',
		FIRSTROW = 50,
        PARSER_VERSION = '1.0'
    ) WITH (
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
    ) AS [result]
