# Load the quantmod package
renv::install('quantmod')
library(quantmod)

# Import QQQ data from Yahoo! Finance
getSymbols(Symbols = "QQQ", auto.assign = TRUE)

str(QQQ)
head(QQQ)


# Alpha Vantage is a source similar to Yahoo! Finance. 
# FRED is an online database of economic time series data 
# created and maintained by the Federal Reserve Bank of St. Louis.

# getSymbols() imports data from Yahoo! Finance by default 
# because src = “yahoo” by default. 
# The src values for Alpha Vantage and FRED are “av” and “FRED”

# Import QQQ data from Alpha Vantage
# getSymbols(Symbols = "QQQ", src = "av")
# https://www.alphavantage.co/ to get API key
# Look at the structure of QQQ
# str(QQQ)

# Import GDP data from FRED
getSymbols(Symbols = "GDP", src = "FRED")

head(GDP)


# Assign SPY data to 'spy' using auto.assign argument
spy <- getSymbols(Symbols = "SPY", auto.assign = FALSE)

# Look at the structure of the 'spy' object
str(spy)

# Assign JNJ data to 'jnj' using env argument
jnj <- getSymbols(Symbols = "JNJ", env = NULL)

# Look at the structure of the 'jnj' object
str(jnj)
