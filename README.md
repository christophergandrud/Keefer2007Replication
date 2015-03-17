Replication Materials for When All is Said and Done: Updating ‘Elections, Special Interests, and Financial Crisis’
=====================

Christopher Gandrud and Mark Hallerberg

*Forthcoming in Research and Politics*

The materials in this repository replicate and explore findings from
[Keefer (2007)](http://dx.doi.org/10.1017/S0020818307070208)
using updated data on the fiscal costs of financial crises from
[Laeven and Valencia (2012)](https://www.imf.org/external/pubs/cat/longres.aspx?sk=26015.0).

## Model Estimation

The [analysis/ModelUpdate.do](analysis/ModelUpdate.do) Stata 12.1 estimates
the regression models.

## Tables

Tables of these results shown in the paper's main text and supplementary
materials can then be created by
[analysis/StataResultsTableMaker.R](analysis/StataResultsTableMaker.R) in R.

## Figures

Figures in the paper are created with
[analysis/FiguresReplicationV2.R](analysis/FiguresReplicationV2.R).

## Data

Replication data can be found in the [data/](data/) subdirectory. The
fiscal cost estimates from the data sets discussed in the paper are in
[data/KeeferFiscal.csv](data/KeeferFiscal.csv). The R file
[data/KeeferDataExtender.R](data/KeeferDataExtender.R) gathers covariates
and combines them with the fiscal costs data to create
[data/KeeferExtended_RandP.dta](data/KeeferExtended_RandP.dta).
