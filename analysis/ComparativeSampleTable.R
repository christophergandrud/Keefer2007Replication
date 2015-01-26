###########
# Replication file comparative sample table in 'When All is Said and Done'
# Christopher Gandrud
# 26 January 2015
###########


# Set data directory
DD <- '/git_repositories/Keefer2007Replication/data/'

# Load packages
library(foreign)
library(dplyr)

# -------------------------------------------------------------------- #
#### Compare fiscal costs in LV vs. HK ####
## Data set created using:
## https://github.com/christophergandrud/CrisisDataIssues/blob/master/source/DataCreators/KeeferDataExtender.R

Main <- read.dta(paste0(DD, 'KeeferExtended_Limited.dta'))

# Subset
keefer <- Main %>% filter(!is.na(Keefer2007_Fiscal)) %>% 
    select(country, year, DiEiec33)

keefer$colour <- keefer$DiEiec33