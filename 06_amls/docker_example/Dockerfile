## Run AlphaFold2 (ColabFold) in Azure Machine Learning
FROM mcr.microsoft.com/azureml/openmpi3.1.2-cuda10.2-cudnn7-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive
USER root

## Set an working directory for the ML resources
WORKDIR /alphafold2

## Install System Libraries and Azure ML Dependencies
RUN apt-get update && \
    apt-get -y install g++ gcc git

RUN conda install -c r -y \
    conda \
    openssl=1.1.1c && \
    conda clean -ay

RUN pip install --no-cache-dir \
    azureml-defaults \
    azureml-dataprep\
    azureml-core \
    azure-ml-api-sdk \
    azureml-train-automl-runtime

## Install Torch
RUN conda install -y -c pytorch \
    cudatoolkit \
    pytorch \
    torchvision && \
    conda clean -ya

## Install ColabFold 
RUN pip install --no-warn-conflicts -q "colabfold[alphafold] @ git+https://github.com/sokrypton/ColabFold"

## Download ColabFold data
RUN python -m colabfold.download

## Install Bio-Dependencies
RUN conda install -y -q \
    -c conda-forge \
    -c bioconda \
    kalign3=3.2.2 \
    hhsuite=3.3.0 \
    openmm=7.5.1 \
    pdbfixer
