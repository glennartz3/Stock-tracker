# Title: stock tracker standard packages

# Purpose : This script performs a time series analyses on 
#           stock data.
#           Data consists of start and end costs for stocks 
#           collected from Yahoo Finance API 
#           between 1950 and 2024. 
#           For details of see:
#           yahoo finance api documentation

# source data:''
# add env name and data

# Author: G. Lennartz
# Contact details: glennartz3@gmail.com

# Date script created: Jan 19, 2024 
# Date script last modified: Jan 19, 2024 

print('Loading standard package set')
# package dependencies

library(renv)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(usethis)
library(RSQLite)

# renv::install()

# good practice to include session information
# xfun::session_info()
# sessionInfo()

#  packages for project env
# lapply(.libPaths(), list.files)
# .libPaths()

# getOption("repos")
