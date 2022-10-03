## See example below
rdd <- read_dta("rdd.dta")
rdd <- rdd %>%
filter(index > 2799 & index < 3000)

library(rdrobust)
rdplot(rdd$matriculated,rdd$index - 2900, p = 1) 
