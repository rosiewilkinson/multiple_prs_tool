#!/usr/bin/bash

set -ex

### Arguments provided as ordered
### $1 : GENETIC DATA PATH - PLINK data
### $2 : WEIGHTS PATH - PRS based on known genetic variants, unique to this pipeline
### $3 : PHENOTYPE AND COVARIATE DATA PATH -  phenotype data
### $4 : PHENOTYPE NAME - e.g. BMI column name
### $5 : QT COVARIATES (COMMA SEPARATED: "NONE" IF NONE) 
### $6 : CATEGORICAL COVARIATES (COMMA SEPARATED: "NONE" IF NONE)
### $7 : RESIDUALISE PHENOTYPE (Y/N)
### $8 : INVERSE NORMALISE PHENOTYPE (Y/N)
### $9 : OUTPUT PREFIX

### ASSIGN MEANINGFUL VARIABLE NAMES TO COMMAND LINE VARIABLES

# Path of genetic data
GENETICDATA=$1

# Path of weights file
PLINKWEIGHTS=$2
# Gwas summary stats
GWAS=$3
# PRSICE formatted phenotype (FID | IID | PHENO - tab delimiated)
PRSICEPHENO=$4
# PRSice formatted covariate file
PRSICECOV=$5
# Binary Target? (T/F)
TARGETTYPE=$6
# STAT COLUMN (OR/BETA)
STAT=$7
# EFFECT SIZE TYPE (or/beta)
EFFECTSIZETYPE=$8
# Output prefix for files
OUT=$9

# PLINK PRS PIPELINE

/slade/home/rw673/prs_generating_tool/scripts/plink_prs.sh ${GENETICDATA} ${PLINKWEIGHTS} ${OUT}

# PRSICE2 PRS PIPELINE

/slade/home/rw673/prs_generating_tool/scripts/prsice2_prs.sh ${GWAS} ${GENETICDATA} ${TARGETTYPE} ${PRSICEPHENO} ${PRSICECOV} ${STAT} ${EFFECTSIZETYPE} ${OUT}


# SBAYESR/GCTB PRS PIPELINE 

/slade/home/rw673/prs_generating_tool/scripts/sbayesr_prs.sh ${GWAS} ${GENETICDATA} ${OUT}
