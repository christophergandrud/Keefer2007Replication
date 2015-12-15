Replication Materials for When All is Said and Done: Updating ‘Elections, Special Interests, and Financial Crisis’
=====================

Christopher Gandrud and Mark Hallerberg

*[Research and Politics](http://rap.sagepub.com/content/2/3/2053168015589335)*

The materials in this repository replicate and explore findings from
[Keefer (2007)](http://dx.doi.org/10.1017/S0020818307070208)
using updated data on the fiscal costs of financial crises from
[Laeven and Valencia (2012)](https://www.imf.org/external/pubs/cat/longres.aspx?sk=26015.0).

## Set up

The working directory for all of the source code files is set to
`~/git_repositories/Keefer2007Replication`. Please change as needed.

## Model Estimation

The Stata 12.1 do-file [analysis/ModelUpdate.do](analysis/KeeferModelUpdate.do)
estimates the regression models. Note: the `regsave` and `betafit` commands must
be `ssc` installed.

## Tables

Tables of these results shown in the paper's main text and supplementary
materials can then be created by
[analysis/StataTableMaker.R](analysis/StataTableMaker.R) in R.

Table 2 from the Supplementary Materials showing the comparative samples and
observations' electoral competitiveness is created using
[analysis/ComparativeSampleTable.R](analysis/ComparativeSampleTable.R).

## Figures

Figures in the paper are created with
[analysis/Figures.R](analysis/Figures.R).

## Data

Replication data can be found in the [data/](data/) subdirectory. The
fiscal cost estimates from the data sets discussed in the paper are in
[data/KeeferFiscal.csv](data/KeeferFiscal.csv). The R file
[data/KeeferDataExtender.R](data/KeeferDataExtender.R) gathers covariates
and combines them with the fiscal costs data to create
[data/KeeferExtended_RandP.dta](data/KeeferExtended_RandP.dta).
