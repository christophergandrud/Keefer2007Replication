#####################
# Create .tex tables for Keefer (2007) update
# Tables created with analysis/ModelUpdate.do in Stata 12.1
# Christopher Gandrud
# 27 January 2015
#####################

library(foreign)
library(dplyr)
library(DataCombine)
library(xtable)

# Set working directory. Change as needed.
setwd('/git_repositories/Keefer2007Replication/tables/')

# Get list of individual model tables
TableA<- data.frame
AllFiles <- list.files()

filesA <- AllFiles[grep('A', AllFiles)] # linear models
filesB <- AllFiles[grep('^B', AllFiles)] # beta regression

# Combine into data frames
CombineFiles <- function(file_list, start){
    for (i in file_list) {
        temp <- read.dta(i)
        if (i == start) out <- temp
        else out <- merge(out, temp, by = 'var', all = TRUE, sort = FALSE)
    }
    return(out)
}

outputA <- CombineFiles(filesA, start = 'A1.dta')
outputB <- CombineFiles(filesB, start = 'B1.dta')
outputC <- CombineFiles(c('C1.dta', 'A1.dta'), start = 'C1.dta')

CleanUp <- data.frame(
        from = c('proportion:_cons', 'zeroinflate:_cons',
                'proportion:', 'zeroinflate:',
                'mu:_cons', 'ln_phi:_cons',
                 "^.*?_stderr", "_coef", "_cons", "Checks33", "DiEiec33",
                 "stabnsLag3", "r2", "N_clust", "mu:", "N",
                 "No. of Countrieso. of Clusters"),
        to = c('(Beta) constant', 'Pr(y=0) constant',
                '(Beta) ', 'Pr(y=0) ',
                'mu constant', 'ln phi constant', '', '', "constant",
               "Checks_Residual_33", "Electoral Comp._33",
               "Instability_AVG_LAG3", "R2", "No. of Clusters", '',
               'No. of Countries', "No. of Clusters")
    )

#### Final clean up for the linear models ####
outputA <- FindReplace(outputA, Var = 'var', replaceData = CleanUp, exact = F)
outputA <- outputA[1:11, ]
names(outputA) <- c('', 'Keefer', 'LV-Keefer', 'LV pre-2001', 'LV Full')

# Save as .tex table
print(xtable(outputA, dcolumn = TRUE, booktabs = TRUE),
      include.rownames = FALSE, floating = FALSE, file = 'UpdateLinear.tex')

#### Final clean up for the beta model ####
outputB <- FindReplace(outputB, Var = 'var', replaceData = CleanUp, exact = F)
outputB <- outputB[c(1:11, 20), ]
names(outputB) <- c('', 'Keefer', 'LV pre-2001', 'LV Full')

# Save as .tex table
print(xtable(outputB, dcolumn = TRUE, booktabs = TRUE),
      include.rownames = FALSE, floating = FALSE, file = 'UpdateBeta.tex')

#### Final clean up for HK linear models ####
outputC <- FindReplace(outputC, Var = 'var', replaceData = CleanUp, exact = F)
outputC <- outputC[1:11, ]
names(outputC) <- c('', 'HK', 'Keefer')

# Save as .tex table
print(xtable(outputC, dcolumn = TRUE, booktabs = TRUE),
      include.rownames = FALSE, floating = FALSE, file = 'UpdateHK.tex')

#### Eurozone out table ####
eu <- read.dta('A6.dta')
eu <- FindReplace(eu, Var = 'var', replaceData = CleanUp, exact = F)
eu <- eu[1:11,]
names(eu) <- c('', 'LV, no Eurozone')

# Save as .tex table
print(xtable(eu, dcolumn = TRUE, booktabs = TRUE),
      include.rownames = FALSE, floating = FALSE, file = 'UpdateNoEurozone.tex')
