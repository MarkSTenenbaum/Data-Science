## NECESSARY LIBRARIES
library(tidyverse)
library(libridate)
library(hms)

## TYPES OF DATES/TIMES      (use class() to see type on a date/time)
# - Date:    just date
# - POSIXct: date and time (portable operating system interface caleendar time)
# - hms:     hours, minutes, seconds


## WHAT IS THE TIME ------------------------------------------------------------
today()        # today's date in "date" class
now()          # today's date + time in "POSIXct" class
Sys.time()     # Same as above
Sys.timezone() # timezone
as_hms(now())  # current time 


## CREATING DATE/TIME VARIABLES ------------------------------------------------
make_date(year = 1981, month = 6, day = 25)              # creating date
make_datetime(year = 1972, month = 2, day = 22,          # creating date/time
              hour = 10, min = 9, sec = 01)

library(nycflights13)                                    # example in tidyverse
data("flights")
flights <- flights %>%
  mutate(datetime = make_datetime(year   = year, 
                                  month  = month, 
                                  day    = day,
                                  hour   = hour,
                                  min = minute)) %>%
  select(flights, datetime)


# AUTOMATICALLY CONVERT TO DATE/TIME FORMAT ------------------------------------
as_hms()                                                # covert to hms
as_date()                                               # convert to date
as_datetime()                                           # convert to POSIXct 
as.numeric()                                            # convert to epoch time
ymd(20200628, tz = 'UTC')                               # year-month-date
ymd(c("2011/01-10", "2011-01/10", "20110110"))          # convert multiple
mdy(c("01 adsl; 10 df 2011", "January 10, 2011"))       # month-day-year
hms(c("10:40:10", "10 40 10"))                          # hour-minute-second
ms("10-10")                                             # minute-second
ymd_hms()                                               # date-time ymd
mdy_hms("05/26/2004 UTC 11:11:11.444")                  # date-time mdy
dmy()                                                   # day-monty-year
force_tz(d1, tzone = "America/New_York")                # keep time, change zone
with_tz(d1, tzone = "America/New_York")                 # change time and zone


## MANUALLY CONVERT DATE/TIME FORMAT --------------------------------------------
w <- parse_date("10/11/2020",                           # parse date
                format = "%m/%d/%Y")  
x <- parse_datetime("10/11/2020 11:59:20",              # parse date/time
                    format = "%m/%d/%Y %H:%M:%S")
y <- parse_time("11:59:20",                             # parse time
                format = "%H:%M:%S")
z <- parse_datetime('05/26/2004 UTC 11:11:11.444',      # example w/ extra text 
                    format = '%m/%d/%Y UTC %H:%M:%S')


## EXTRACTING COMPONENTS ------------------------------------------------------
year()                                                  # year
month()                                                 # month
week()                                                  # week
mday()                                                  # day of month
wday()                                                  # day of week
yday()                                                  # day of year
hour()                                                  # hour
minute()                                                # minute
second()                                                # second

ddat <- mdy_hms("01/02/1970 03:51:44")                  # changing year of date
month(ddat, label = TRUE) =
2023 -> year(ddat) #

ddat <- mdy_hms("01/02/1970 03:51:44")                  # another way to do this
ddat <- update(ddat, year = 1999)


## ADDING/SUBTRACTING DATES/TIMES ---------------------------------------------
minutes()
hours()
days()
weeks()
months()
years()

years(2020) + months(2)                   # add different units of time
now() + days(2)                           # two days from today

next_year <- today() + years(1)           # num days until today 1 yr from now
(today() %--% next_year) / ddays(1)

next_year <- today() + years(1)           # num months until today 1 yr from now
(today() %--% next_year) / months(1)

wmta <-  wmata %>%                        # example using tidyverse
  mutate(year = year(Date),
         month = month(Date),
         day  = wday(Date, label = TRUE)) %>%
  filter(year != 2004) 

## DURATIONS ------------------------------------------------------------------
as.duration()                            # e.g., age <- as.duration(age1 - age2)

dyears(1)                                # these all convert from X to SECONDS
ddays(1)
dhours(1)
dminutes(1)
dseconds(1)

dweeks(3) + ddays(5)                                # duration of time

one_pm <- ymd_hms("2016-03-12 13:00:00",
                  tz = "America/New_York")
one_pm + ddays(1)                                   # same as one_pm + days(1)

wmata <- read_csv("../../data/wmata_ridership.csv") # example
rng <- range(wmata$Date)
as.duration(rng[2] - rng[1])
as.interval(rng[2] - rng[1], start = rng[1]) / years(1)

### ROUNDING DATES/TIMES -------------------------------------------------------
ddat <- mdy_hms("01/02/1970 03:51:44")
ddat
round_date(ddat, unit = "year")
floor_date(ddat, unit = 'year')
ceiling_date(ddat, unit = 'year')

  
## DATE/TIME FUNCTION ---------------------------------------------------------
make_date_time_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

## Useful example of this (taking datetime variable in POSIXct form, converting it to date (which takes default ymd form), and then filtering for flights on a specific date by entering the specific date in ymd form)
flights %>% 
  filter(as_date(datetime) == ymd(20130704)) %>%
  ggplot(aes(x = datetime)) +
  geom_freqpoly(binwidth = 600)

# More examples
fake %>%
  mutate(month = str_to_sentence(month),
         month = parse_factor(month, levels = month.abb),
         month_num2 = as.numeric(month),
         date = make_date(year = year, month = month_num2, day = day)) %>%
  filter(date > ymd(20100201))

fake %>%
  mutate(date = make_date(year = year, month = month_num, day = day)) %>%
  filter(date > ymd(20100201))
