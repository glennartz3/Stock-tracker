# Load the Quandl package
# renv::install('Quandl')
library(Quandl)

# Import GDP data from FRED
gdp <- Quandl(code = "FRED/GDP")

# Look at the structure of the object returned by Quandl
str(gdp)
head(gdp)

# Import GDP data from FRED as xts
gdp_xts <- Quandl(code = "FRED/GDP", type = "xts")

# Look at the structure of gdp_xts
head(gdp_xts)

# Import GDP data from FRED as zoo
gdp_zoo <- Quandl(code = "FRED/GDP", type = "zoo")

# Look at the structure of gdp_zoo
head(gdp_zoo)

# Create an object containing the Pfizer ticker symbol
symbol <- "PFE"

# Use getSymbols to import the data
getSymbols("PFE")
head(PFE)


# Create a currency_pair object
currency_pair <- "GBP/CAD"

# Load British Pound to Canadian Dollar exchange rate data
getSymbols(currency_pair, src = "oanda")

quantmod::oanda.currencies

# Try to load data from 190 days ago
getSymbols(currency_pair, from = Sys.Date() - 190, to = Sys.Date(), src = "oanda")


# Create a series_name object
series_name <- "UNRATE"

# Load the data using getSymbols
getSymbols(series_name, src = "FRED")

# Create a quandl_code object
quandl_code <- "FRED/UNRATE"

# Load the data using Quandl#
unemploy_rate <- Quandl(quandl_code)


# load(file = "DC.RData")
getSymbols("DC")

DC <- DC[,c(1,2)]
DC <- to.hourly(DC, indexAt = "startof")

# Extract the close column
dc_close <- Cl(DC)

# Look at the head of dc_close
head(dc_close)

# Extract the volume column
# dc_volume <- Vo(DC)

# Look at the head of dc_volume
# head(dc_volume)

# Extract the high, low, and close columns
dc_hlc = HLC(DC)

# Look at the head of dc_hlc
head(dc_hlc)

# Extract the open, high, low, close, and volume columns
# dc_ohlcv = OHLCV(DC)

# Look at the head of dc_ohlcv
# head(dc_ohlcv)




# Download CME data for CL and BZ as an xts object
oil_data <- Quandl(code = c("CHRIS/CME_QX7", "CFTC/067653_FO_L_ALL_CR"), type = "xts")
colnames(oil_data)

# Extract the Open price for CLH2016
cl_open <- getPrice(oil_data, symbol = "CME_QX7", prefer = "Open$")

# Look at January, 2016 using xts' ISO-8601 subsetting
cl_open["2016-01"]

# Download quarterly CL and BZ prices
qtr_price <- Quandl(code = c("CHRIS/CME_QM1", "CHRIS/CME_QG1"), collapse = "quarterly",type = "xts")

# View the high prices for both series
Hi(qtr_price)

# Download quarterly CL and BZ returns
qtr_return <- Quandl(code = c("CHRIS/CME_QM1", "CHRIS/CME_QG1"), collapse = "quarterly",transform = "rdiff", type = "xts")
head(qtr_return)

# View the settle price returns for both series
getPrice(qtr_return, prefer = "Settle")


# Create new environment
data_env <- new.env()
# Use getSymbols to load data into the environment
getSymbols(c("SPY", "QQQ"), env = data_env, auto.assign = TRUE)

head(data_env$SPY, 3)

eapply(data_env, head)

# Call head on each object in data_env using eapply
data_list <- eapply(data_env, head)

# Merge all the list elements into one xts object
data_merged <- do.call(merge, data_list)

# Ensure the columns are ordered: open, high, low, close
data_ohlc <- OHLC(data_merged)
data_ohlc

# Extract volume column from each object
adjusted_list <- lapply(data_env, Ad)
# Merge each list element into one object
adjusted <- do.call(merge, adjusted_list)
head(adjusted)


# Symbols
symbols <- c("AAPL", "MSFT", "IBM")

# Create new environment
data_env <- new.env()

# Load symbols into data_env
getSymbols(symbols, env = data_env)

# Extract the close column from each object and combine into one xts object
close_data <- do.call(merge, eapply(data_env, Cl))

# View the head of close_data
head(close_data)


# Set the default to pull data from Alpha Vantage
setDefaults(getSymbols, src = "av")

# Get GOOG data
getSymbols("GOOG")

# Verify the data was actually pulled from Alpha Vantage
str(GOOG)

# Look at getSymbols.yahoo arguments
args(getSymbols.yahoo)

# Set default 'from' value for getSymbols.yahoo
# setDefaults(getSymbols.yahoo, from = "2000-01-01")
# 
# # Confirm defaults were set correctly
# getDefaults("getSymbols.yahoo")
# 
# 
# setDefaults(getSymbols, src = "yahoo")
# setSymbolLookup("CP" = "yahoo")
# # Load CP data again
# getSymbols("CP")
# 
# setSymbolLookup("CP" = NULL)
# 
# # Set the source for CP to FRED
# setSymbolLookup("CP" = "FRED")
# 
# # Load CP data again
# getSymbols("CP")
# 
# # Save symbol lookup table
# saveSymbolLookup("my_symbol_lookup.rda")
# 
# # Set default source for CP to "yahoo"
# setSymbolLookup("CP" = "yahoo")
# 
# # Verify the default source is "yahoo"
# getSymbolLookup("CP")
# 
# # Load symbol lookup table
# loadSymbolLookup("my_symbol_lookup.rda")
# getSymbolLookup("CP")