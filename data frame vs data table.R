

####### DATAFRAME VS DATA TABLE ################################################
library(tidyverse)
library(dplyr)
library(data.table)

## CONVERTING TO DT FROM DF ------------------------------------------------
tribble(
  ~ID, ~A, ~B,  ~C,
  "b", 1,   7,  13,  
  "b", 2,   8,  14,
  "b", 3,   9,  15,
  "a", 4,   10,  16,
  "a", 5,   11,  17,
  "c", 6,   12,  18,
) ->
  DF # 
DT <- as.data.table(DF)


## DAVE CSV FROM DT OR DF ---------------------------------------------
fwrite()               # dt
write.csv()            # df


## WHEN TO USE DF VS DT ------------------------------------------------
# - Use data.table for large data sets that you read
# - in with fread() (DF < 1M rows)


## READING DF AND DT------------------------------------------------------
setwd("~/Downloads")
flights1 <- fread("nycdata.csv")             # produces dt
flights2 <- read_csv("nycdata.csv")          # produces a tibble


## EXAMINE STRUCTURE ----------------------------------------------------
str(flights1)                               # data.table way
glimpse(flights2)                           # tidyverse way


## FILTERING/ARRANGING ROWS (Observations) -------------------------------
# Filter by value of columns datatable way
flights1[origin == "JFK" & dest == "LAX"]

# Filter by value of columns tidyverse (df) way
flights2 %>%
  select(carrier,origin,dest)%>%
  filter(origin == "JFK", dest == "LAX") 

# specific row numbers datatable way
flights1[c(1, 3, 207)] 

# specific row numbers datatable way tidyverse way
flights2%>%
  slice(3, 5, 208)

# reorder rows data.table way
flights1[order(origin, -dest)]

# reorder rows tidyverse way    
flights2 %>%
  select(year,month,day,carrier,origin,dest)%>%
  arrange(origin, desc(dest))


## SELECTING COLUMNS (Variables) --------------------------------------------
# data.table way
flights1[, .(origin, dest)]

# Or
flights1[, list(origin, dest)]

# Or
flights1[, c("origin", "dest")]               # add
flights1[, !c("year", "month")]               # subtract

# Or
flights1[, origin:dest]                       # add
flights1[, !(year:month)]                     # subtract


# equivalent tidyverse way
flights2 %>%
  select(origin, dest)                        # add

flights2%>%
  select(-year, -month)                       # subtract



## EXAMPLES COMBINING FILTERING AND SELECTING -------------------------------
# data.table way
flights1[origin == "JFK" & dest == "LAX", .(year, month, day, hour)]

# or (and more descriptive)  preferred method
flights1[origin == "JFK" & dest == "LAX", .(year, month, day, hour,
                                            origin, dest)]

# tidyverse way
flights2 %>%
  select(year, month, day, hour, origin, dest)%>%
  filter(origin == "JFK", dest == "LAX")


## CREATING NEW VARIABLES (mutate) -----------------------------------------
# data.table way
flights1[, c("gain") := .(dep_delay - arr_delay)]

# equivalent tidyverse way    
flights2 %>%
  mutate(gain = dep_delay - arr_delay)

# Removing a column  data.table way      
flights1[, c("gain") := .(NULL)]       # remove col by setting variable to NULL


## equivalent tidyverse way
flights2 %>%
  select(-gain) 


# Add multiple variables by separating them with commas
flights1[, c("gain", "dist_km") := .(dep_delay - arr_delay, 
        1.61 * distance)]

# Eliminate the added columns by using NULL
flights1[, c("gain", "dist_km") := .(NULL, NULL)]
flights1


## GROUP SUMMARIES ----------------------------------------------------------
# meandata.table way
flights1[, .(meandd = mean(dep_delay))]

## mean tidyverse way
flights2 %>%
  summarize(meandd = mean(dep_delay))

# multiple summaries data.table way
flights1[, .(meandd = mean(dep_delay), meanad = mean(arr_delay))]

# multiple summaries tidyverse way
flights2 %>%
  summarize(meandd = mean(dep_delay), meanad = mean(arr_delay))

# number of rows datatable
flights1[, .(.N)]

# number of rows tidyverse
flights2 %>%
  count()

# group summaries datatable
flights1[, .(meandd = mean(dep_delay)) , by = .(origin)]

# group summaries tidyverse
flights2 %>%
  group_by(origin) %>%
  summarize(meandd = mean(dep_delay))


## RECODING VARIABLES -----------------------------------------------------
# recoding DT way
flights1[carrier == "AA", carrier := "AmerAir"]

## recoding tidyverse way
flights2 %>%
  mutate(carrier = recode(carrier, "AA" = "AmerAir")) ->
  flights2


## UNITING VARIABLES ----------------------------------------------------
# uniting "century" and "year" columns DT way
table5
dt5 <- as.data.table(tidyr::table5)
dt5[, year := paste(century, year, sep = "")]
dt5[, century := NULL]

# uniting "century" and "year" columns DT way tidyverse methods
table5 %>%
  unite(century, year, col = "year", sep = "")


## CHAINING/PIPING VARIABLES --------------------------------------------
#tidyverse way and then alphabetizing by orgin.
flights2 %>%
  select(carrier,origin, dest)%>%
  filter(carrier == "AmerAir") %>%
  group_by(origin, dest) %>%
  summarize(meanad = mean(arr_delay)) %>%
  arrange(origin, desc(dest)) -> flights2a
flights2a

## data.table way
flights1[carrier == "AmerAir", .(meanad = mean(arr_delay)),
        by = .(origin, dest)][order(origin, -dest)]

## JOINING ------------------------------------------------------------

# We'll use the following data.tables to introduce joining.


xdf <- data.table(mykey = c("1", "2", "3"),
                  x_val = c("x1", "x2", "x3"))

ydf <- data.table(mykey = c("1", "2", "4"),
                  y_val = c("y1", "y2", "y3"))

# data.table way
merge(xdf, ydf, by = "mykey")

# equivalent tidyverse way
inner_join(xdf, ydf, by = "mykey")

# Outer Joins (Left, Right, Full)

# Left Join
# data.table way
merge(xdf, ydf, by = "mykey", all.x = TRUE)

# equivalent tidyverse way
left_join(xdf, ydf, by = "mykey")

# Right Join

# data.table way
merge(xdf, ydf, by = "mykey", all.y = TRUE)

# equivalent tidyverse way
right_join(xdf, ydf, by = "mykey")


# Full Join

# data.table way
merge(xdf, ydf, by = "mykey", all.x = TRUE, all.y = TRUE)

# equivalent tidyverse way
full_join(xdf, ydf, by = "mykey")


# Binding Rows:
  
# data.table way
rbind(xdf, ydf, fill = TRUE)

# equivalent tidyverse way
bind_rows(xdf, ydf)


