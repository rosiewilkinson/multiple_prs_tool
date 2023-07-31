#!/usr/bin/bash

set -ex 

GWAS=$1

GENETICDATA=$2

TARGETTYPE=$3

PRSICEPHENO=$4

PRSICECOV=$5

STAT=$6

EFFECTSIZETYPE=$7

OUT=$8

# RUNNING PRSICE
module load R-bundle-Packages
Rscript /slade/home/rw673/prs_generating_tool/executables/PRSice.R \
        --prsice /slade/home/rw673/prs_generating_tool/executables/PRSice_linux \
        --base ${GWAS} \
        --target ${GENETICDATA} \
        --binary-target ${TARGETTYPE} \
        --pheno ${PRSICEPHENO} \
        --cov ${PRSICECOV} \
        --base-maf MAF:0.01 \
        --base-info INFO:0.8 \
        --stat ${STAT} \
        --${EFFECTSIZETYPE} \
        --out ${OUT} 





