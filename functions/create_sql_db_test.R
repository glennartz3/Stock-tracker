library(yfR)
library(ggplot2)
library(dplyr)
library(RSQLite)

# get all the tickers in the s&p 500
df_sp500 <- yf_index_composition("SP500")
# glimpse(df_sp500)
head(df_sp500)

# use collection call for multiple tickers
data_sp500 = yfR::yf_collection_get("SP500")
head(data_sp500)


conn <- dbConnect(RSQLite::SQLite(), "ticker_map.db")

# Write the mtcars dataset into a table names mtcars_data
dbWriteTable(conn, "ticker_map", df_sp500)

# Write the mtcars dataset into a table names mtcars_data
dbWriteTable(conn, "test_batch_data_1", data_sp500)

# List all the tables available in the database
dbListTables(conn)

dbGetQuery(conn, "SELECT * FROM test_batch_data_1 limit 10")

# Close the database connection to CarsDB
dbDisconnect(conn)
