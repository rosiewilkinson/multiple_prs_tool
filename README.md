# Multiple PRS Tool
This repository contains code to generate three different PRS'.

## User Input Files

### PLINK Files
The binary .bim, .bam and .fam files are required for your study.

---

### SNP weights file
Tab delimited file, containing chromosome position | trait increasing allele | other allele | weight 
```
1	2069172 T	C	0.0276996
1	9292282 A	G	0.0280027
1	11284336        A	G	0.0198332
1	17306675        G	C	0.0400801
1	19763396        A	C	0.0187372
```
If the outcome is binary, then the weight needs to be the log(OR).

---

### GWAS Summary Stats
SNP | A1 | A2 | N | SE | P | BETA | INFO (Tab delimited)
If the INFO column is not available, create a new column called INFO and set all values to 1.
If the outcome in binary, the effect estimate column needs to be `OR` (odds ratio).

### PRSice2 Covariate file
The first column and second column must be (FID | IID), the remaining columns

### PRSice2 Phenotype file
(FID | IID | PHENO) - tab delimited

## Bash Command
The files need to be specified in this order on the command line.
```
bash ./prs_tool.sh \
name_of_plink_files \
name_of_weights_file.txt \
gwas_summary_stats.txt \

```

## Outputs

# PLINK
*profile.txt
```
FID     IID     PHENO   CNT     CNT2    SCORE
1000011 1000011 -9 2120140 1032814 0.000180225
1000032 1000032 -9 2124908 1033661 0.00018426
1000048 1000048 -9 2120454 1031894 0.000177185
```

# PRSice2
*.best
```
FID IID In_Regression PRS
1000011 1000011 Yes 0.000666031013
1000032 1000032 Yes 0.000689074663
1000048 1000048 Yes 0.000584237552
1000057 1000057 Yes 0.000655143062
1000064 1000064 Yes 0.000626485321
1000073 1000073 Yes 0.00081223591
```

# SbayesR
*.snpRes
```

```
