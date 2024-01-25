# renv::install('RSQLite')

# Load the RSQLite Library
library(RSQLite)

# Load the mtcars as an R data frame put the row names as a column, and print the header.
data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <- c()
head(mtcars)

# Create a connection to our new database, CarsDB.db
# you can check that the .db file has been created on your working directory
conn <- dbConnect(RSQLite::SQLite(), "CarsDB.db")

# Write the mtcars dataset into a table names mtcars_data
dbWriteTable(conn, "cars_data", mtcars)
# List all the tables available in the database
dbListTables(conn)

# Create toy data frames
car <- c('Camaro', 'California', 'Mustang', 'Explorer')
make <- c('Chevrolet','Ferrari','Ford','Ford')
df1 <- data.frame(car,make)
car <- c('Corolla', 'Lancer', 'Sportage', 'XE')
make <- c('Toyota','Mitsubishi','Kia','Jaguar')
df2 <- data.frame(car,make)
# Add them to a list
dfList <- list(df1,df2)
# Write a table by appending the data frames inside the list
for(k in 1:length(dfList)){
  dbWriteTable(conn,"Cars_and_Makes", dfList[[k]], append = TRUE)
}
# List all the Tables
dbListTables(conn)

dbGetQuery(conn, "SELECT * FROM Cars_and_Makes")

# Gather the first 10 rows in the cars_data table
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 10")

# Get the car names and horsepower of the cars with 8 cylinders
dbGetQuery(conn,"SELECT car_names, hp, cyl FROM cars_data
                 WHERE cyl = 8")

# Get the car names and horsepower starting with M that have 6 or 8 cylinders
dbGetQuery(conn,"SELECT car_names, hp, cyl FROM cars_data
                 WHERE car_names LIKE 'M%' AND cyl IN (6,8)")

# Get the average horsepower and mpg by number of cylinder groups
dbGetQuery(conn,"SELECT cyl, AVG(hp) AS 'average_hp', AVG(mpg) AS 'average_mpg' FROM cars_data
                 GROUP BY cyl
                 ORDER BY average_hp")

avg_HpCyl <- dbGetQuery(conn,"SELECT cyl, AVG(hp) AS 'average_hp'FROM cars_data
                 GROUP BY cyl
                 ORDER BY average_hp")
avg_HpCyl
class(avg_HpCyl)


# Lets assume that there is some user input that asks us to look only into cars that have over 18 miles per gallon (mpg)
# and more than 6 cylinders
mpg <-  18
cyl <- 6
Result <- dbGetQuery(conn, 'SELECT car_names, mpg, cyl FROM cars_data WHERE mpg >= ? AND cyl >= ?', params = c(mpg,cyl))
Result

# Assemble an example function that takes the SQLite database connection, a base query,
# and the parameters you want to use in the WHERE clause as a list
assembleQuery <- function(conn, base, search_parameters){
  parameter_names <- names(search_parameters)
  partial_queries <- ""
  # Iterate over all the parameters to assemble the query
  for(k in 1:length(parameter_names)){
    filter_k <- paste(parameter_names[k], " >= ? ")
    # If there is more than 1 parameter, add an AND statement before the parameter name and placeholder
    if(k > 1){
      filter_k <- paste("AND ", parameter_names[k], " >= ?")
    }
    partial_queries <- paste(partial_queries, filter_k)
  }
  # Paste all together into a single query using a WHERE statement
  final_paste <- paste(base, " WHERE", partial_queries)
  # Print the assembled query to show how it looks like
  print(final_paste)
  # Run the final query. I unlist the values from the search_parameters list into a vector since it is needed
  # when using various anonymous placeholders (i.e. >= ?)
  values <- unlist(search_parameters, use.names = FALSE)
  result <- dbGetQuery(conn, final_paste, params = values)
  # return the executed query
  return(result)
}

base <- "SELECT car_names, mpg, hp, wt FROM cars_data"
search_parameters <- list("mpg" = 16, "hp" = 150, "wt" = 2.1)
result <- assembleQuery(conn, base, search_parameters)
result


# Visualize the table before deletion
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 10")
# Delete the column belonging to the Mazda RX4. You will see a 1 as the output.
dbExecute(conn, "DELETE FROM cars_data WHERE car_names = 'Mazda RX4'")
# Visualize the new table after deletion
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 10")

# Insert the data for the Mazda RX4. This will also ouput a 1
dbExecute(conn, "INSERT INTO cars_data VALUES (21.0,6,160.0,110,3.90,2.620,16.46,0,1,4,4,'Mazda RX4')")
# See that we re-introduced the Mazda RX4 succesfully at the end
dbGetQuery(conn, "SELECT * FROM cars_data")

# Close the database connection to CarsDB
dbDisconnect(conn)
