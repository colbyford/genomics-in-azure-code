## Install miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p

## Add Conda to PATH
export PATH="/shared/home/cyclecloudadmin/miniconda3/bin/:$PATH"
conda init bash

## Create demo directory
mkdir snakemake_demo
cd snakemake_demo

## Get Snakemake dependency requirements from repo
wget https://github.com/snakemake/snakemake-tutorial-data/archive/v5.24.1.tar.gz
tar --wildcards -xf v5.24.1.tar.gz --strip 1 "*/data" "*/environment.yaml"

## Create Snakemake environment (and activate it)
conda activate base
conda env create -n snakemake_env -f environment.yaml
conda activate snakemake_env