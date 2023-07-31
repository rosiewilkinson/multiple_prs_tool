# Multiple PRS Tool
This repository contains code to generate three different polygenic risk scores.

## User Input Files

### PLINK Files
The binary .bim, .bam and .fam files are required for your study.

---

### SNP weights file
A tab-delimited file with no headers - (Layout: chromosome position | base-pair position | trait increasing allele | other al$
```
1	2069172 T	C	0.0276996
1	9292282 A	G	0.0280027
1	11284336        A	G	0.0198332
1	17306675        G	C	0.0400801
1	19763396        A	C	0.0187372
```
If the trait is binary, the weights must be the log(odds ratio). Whereas if the trait is continuous, the weights must use the$

---

### GWAS Summary Stats
A tab-delimited including the caps-sensitve headers - (Layout: CHR | BP | SNP | A1 | A2 | N | SE | P | BETA/OR | INFO | MAF)
If the INFO column is unavailable, create a new one called INFO and set all values to 1.
If the trait is binary, the effect estimate column needs to be `OR` (log(odds ratio)).
If the trait is continuous, the effect estimate column needs to be `BETA` (beta coefficent).
```
CHR     BP	SNP     A1	A2	N	SE	P	OR	INFO    MAF
1	751756  rs143225517     C	T	185000  .017324 .4528019        .013006 1	.158264
1	752566  rs3094315	A	G	185000  .0157652        .7394597        -.005243        1	.763018
1	752721  rs3131972	G	A	185000  .0156381        .8462652        -.003032        1	.740969
```

---

### PRSice2 Covariate file
The file must include headers and be tab-delimited, the first column and second column must be (FID | IID), and the remaining$

```
IID     FID     age_base        sex     centre_10003    centre_11001
1000011 1000011 64	0	0	0
1000032 1000032 49	1	0	1
1000048 1000048 57	0	0	0
```

---

### PRSice2 Phenotype file
This file must be tab-delimited and include the caps-sensitve headers - (Format: FID | IID | PHENO)
```
IID     FID     cad
1000011 1000011 0
1000032 1000032 0
1000048 1000048 0
```

---

## Bash Command
The files need to be specified in this order on the command line.
```
bash ./prs_tool.sh \
name_of_plink_files \
name_of_weights_file.txt \
gwas_summary_stats.txt \
name_of_phenotype_file.txt \
name_of_covariate_file.txt \
T_or_F_binary_target \
BETA_or_OR_stats_column_name \
or_or_beta_effect_size_type \
output_prefix
```

## Outputs

* - is the output prefix

# PLINK
*.profile.txt
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

# SBayesR
*.sbayesrprs.profile.txt
```
FID     IID     PHENO   CNT     CNT2    SCORE
1000011 1000011 -9 658130 321703 6.01561e-05
1000032 1000032 -9 659352 321942 6.08187e-05
1000048 1000048 -9 658106 321757 6.08512e-05
```
