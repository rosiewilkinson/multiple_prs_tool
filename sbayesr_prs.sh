#!/usr/bin/bash

set -ex

GWAS=$1

GENETICDATA=$2

OUT=$3

# FORMATING GWAS SUMMARY STATS TO SBAYESR FORMAT (MA)

sed 's/MAF/freq/g;s/BETA/b/g;s/OR/or/g;s/SE/se/g;s/P/p/g' ${GWAS} > ${GWAS}.tempma
awk 'BEGIN{OFS=" "} {print $3, $4, $5, $11, $9, $7, $8, $6}' ${GWAS}.tempma > ${GWAS}.ma

# GET MAX N IN 8TH COLUMN OF MA FILE:
MAXN=`awk 'BEGIN{n=0}{if ($8>0+n) n=$8} END{print n}' ${GWAS}.ma`

# DEFINE A MIN N BASED ON 95% OF THE MAX SAMPLE SIXE:
MINN=$(echo $MAXN*0.95 | bc)

# FILTER LINES OUT OF ${GWAS}.ma IF N < $MINN
awk -v x="$MINN" '{ if(NR==1 ||  $8 > x){print $0} }' ${GWAS}.ma > ${GWAS}.n_filtered.ma



# RUNNING SBAYESR ANALYSIS

for i in {1..22}
do
/slade/home/rw673/prs_generating_tool/executables/gctb \
        --sbayes R \
        --ldm /slade/home/rw673/prs_generating_tool/ld_sparse_matrix/ukbEURu_hm3_chr${i}_v3_50k.ldm.sparse \
        --pi 0.95,0.02,0.02,0.01 \
        --gamma 0.0,0.01,0.1,1 \
        --gwas-summary ${GWAS}.n_filtered.ma \
        --chain-length 10000 \
        --burn-in 2000 \
        --out-freq 10 \
        --p-value 0.4 \
        --rsq 0.99 \
        --out ${OUT}.chr${i}
done

# Once files created per chromosome, merge, create weightings file
awk 'BEGIN{OFS="\t"}{if(NR>1){print $3, $4, $5, $6, $8}}'  ${OUT}.chr1.snpRes > ${OUT}_sbayesrweights.txt
for i in {2..22}
do
   awk 'BEGIN{OFS="\t"}{if(NR>1){print $3, $4, $5, $6, $8}}'  ${OUT}.chr${i}.snpRes >> ${OUT}_sbayesrweights.txt
done


# Use weights file to produce PRS using PLINK

/slade/home/rw673/prs_generating_tool/scripts/plink_prs.sh ${GENETICDATA} ${OUT}_sbayesrweights.txt ${OUT}.sbayesrprs
