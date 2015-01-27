################
# Keefer data extender
# Christopher Gandrud
# 27 January 2015
###############

library(DataCombine)
library(countrycode)
library(psData)
library(forecast)
library(dplyr)
library(repmis)
library(WDI)
library(foreign)

# Set working directory. Change as needed.
setwd('/git_repositories/Keefer2007Replication/')


# Fuction for keefer rolling 3 year averages
rollmean3r <- function(x){
  x <- shift(x, -2)
  ma(x, 3, centre = FALSE)
}

rollmean3f <- function(x){
  x <- shift(x, 2)
  ma(x, 3, centre = FALSE)
}

rollmean33 <- function(x){
  xR <- rollmean3r(x)
  xF <- rollmean3f(x)
  Comb <- (xR + xF)/2
}

#### Fiscal transfers data (both Laeven and Valencia (2012) and Keefer (2007))
Fiscal <- read.csv('data/KefferFiscal.csv', 
                   stringsAsFactors = FALSE)
Fiscal <- VarDrop(Fiscal, 'country')
Fiscal$HonohanCrisisOngoing[is.na(Fiscal$HonohanCrisisOngoing)] <- 0

Fiscal <- Fiscal %>% select(-Notes)

# Fiscal <- dMerge(Fiscal, Ongoing, Var = c('iso2c', 'year'), all = TRUE)
Fiscal <- subset(Fiscal, iso2c != '') # Drop Czechoslovakia

#### Database of Political Institutions data 
dpiVars <- c('eiec', 'checks', 'stabns')
DpiData <- DpiGet(vars = dpiVars, OutCountryID = 'iso2c', duplicates = 'drop')
DpiData[, dpiVars][DpiData[, dpiVars] == -999] <- NA

DpiData <- DpiData[order(DpiData$country, DpiData$year), ]

# Dichotomize electoral competitiveness
DpiData$DiEiec <- 0
DpiData$DiEiec[DpiData$eiec >= 6] <- 1

# Create Keefer Forward and Backward Lags
DpiData <- DpiData %>% group_by(country) %>% 
            mutate(DiEiec33 = rollmean33(DiEiec))
DpiData <- DpiData %>% group_by(country) %>% 
            mutate(Checks33 = rollmean33(checks))

# Create backwards lags
DpiData <- DpiData %>% group_by(country) %>%
            mutate(stabnsLag3 = rollmean3r(stabns))

# Find residuals for lagged check
Sub <- DropNA(DpiData, c('DiEiec33', 'Checks33'))
Resid <- lm(DiEiec33 ~ Checks33, data = Sub)
Sub$ChecksResiduals33 <- Resid$residuals
Sub <- Sub[, c('iso2c', 'year', 'ChecksResiduals33')]

# Euro indicator
eu <- 'http://bit.ly/1yRvycq' %>%
        source_data() %>%
        select(iso2c, year)
eu$eurozone <- 1

##### Combine data sets
Comb <- dMerge(DpiData, Sub, Var = c('iso2c', 'year'), all.x = TRUE)
Comb <- dMerge(Comb, Fiscal, Var = c('iso2c', 'year'), all.y = TRUE)
Comb <- dMerge(Comb, eu, Var = c('iso2c', 'year'), all.x = TRUE)
Comb$country <- countrycode(Comb$iso2c, origin = 'iso2c',
                            destination = 'country.name')
Comb$eurozone[is.na(Comb$eurozone)] <- 0

write.dta(Comb, file = 'data/KeeferExtended_RandP.dta')
