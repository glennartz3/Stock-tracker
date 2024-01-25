# renv::install('knitr')
library(yfR)
library(ggplot2)
library(dplyr)

# Parallel computing with package furrr is available

# set options for algorithm
my_ticker <- 'F'
# my_ticker <- '^GSPC' # global s&P?
first_date <- "2000-01-01"
last_date <- Sys.Date()

# Fetches daily/weekly/monthly/annual stock prices/returns
df_yf <- yf_get(tickers = my_ticker, 
                first_date = first_date,
                last_date = last_date)

# output is a tibble with data
glimpse(df_yf)

# tickers as column, better suited for portfolio optimization
prev_month_data_wide = yf_convert_to_wide(df_yf)

n_years <- interval(min(df_yf$ref_date), 
                    max(df_yf$ref_date))/years(1)

total_return <- last(df_yf$price_adjusted)/first(df_yf$price_adjusted) - 1

cat(paste0("n_years = ", n_years, "\n",
           "total_return = ",total_return))

ret_comp <- (1 + total_return)^(1/n_years)  - 1

cat(paste0("Comp Return = ",
           scales::percent(ret_comp, accuracy = 0.01)))



p <- ggplot(df_yf, aes(x = ref_date, y = price_adjusted)) + 
  geom_line() +
  labs(
    title = paste0("SP500 Index Value (", 
                   year(min(df_yf$ref_date)), ' - ',
                   year(max(df_yf$ref_date)), ")"
    ),
    x = "Time", 
    y = "Index Value",
    caption = "Data from Yahoo Finance <https://finance.yahoo.com/>") + 
  theme_light() + 
  scale_y_log10() 

p





n_tickers <- 10
# use collection call for multiple tickers
data_sp500 = yfR::yf_collection_get("SP500")
head(data_sp500[[1]])

# get all the tickers in the s&p 500
df_sp500 <- yf_index_composition("SP500")
glimpse(df_sp500)
head(df_sp500)

rnd_tickers = c('AAPL', 'DHI', 'AMZN', 'CMS', 'FCX', 
                'NRG', 'EXR', 'CFG', 'CI', 'AWK')

df_yf <- yf_get(tickers = rnd_tickers,
                first_date = '2010-01-01',
                last_date = Sys.Date())




p <- ggplot(df_yf, 
            aes(x = ref_date, 
                y = cumret_adjusted_prices, 
                color = ticker)) + 
  geom_line() +
  labs(
    title = paste0("SP500 Index Value (", 
                   year(min(df_yf$ref_date)), ' - ',
                   year(max(df_yf$ref_date)), ")"
    ),
    x = "Time", 
    y = "Accumulated Return (from 100%)",
    caption = "Data from Yahoo Finance <https://finance.yahoo.com/>") + 
  theme_light() + 
  scale_y_log10() 

p



tab_perf <- df_yf |>
  group_by(ticker) |>
  summarise(
    n_years = interval(min(ref_date), 
                       max(ref_date))/years(1),
    total_ret = last(price_adjusted)/first(price_adjusted) - 1,
    ret_comp = (1 + total_ret)^(1/n_years) - 1
  )

tab_perf |> 
  mutate(n_years = floor(n_years),
         total_ret = scales::percent(total_ret),
         ret_comp = scales::percent(ret_comp)) |>
  knitr::kable(caption = "Financial Performance of Several Stocks")
