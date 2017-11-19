library(tidyverse)
library(readxl)
library(lubridate)
library(data.table)

data_for_test <- read_excel("C:/Users/freshmorning/Dropbox/Dentsu_test/data_for_test.xlsx", 
                            col_types = c("date", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric"))
# View(data_for_test)

data_for_test <- mutate(data_for_test, year = year(Date), month = month(Date), day = day(Date))

# attempt A

data_on_first <- filter(data_for_test, day == 1) %>% select(year, month, OOH)
number_of_days <- group_by(data_for_test, year, month) %>%
  summarise(n_days = n())

data_on_first <- left_join(data_on_first, number_of_days, by = c("year", "month"))
data_on_first <- mutate(data_on_first, OOH_daily = OOH / n_days) %>% select(-OOH)


data_for_test_a <- left_join(data_for_test, data_on_first, by = c("year", "month"))

# attempt B

data_for_test_b <- group_by(data_for_test, year, month) %>% 
  mutate(n_days = n(), OOH_daily = max(OOH) / n_days) %>% ungroup()

# first(OOH, order_by = day) fails?


## plots 
base <- ggplot() + geom_line(data = data_for_test_b, aes(x = Date, y = Y))
base

# tz (time zone) is used to creat POSIXct object and not Date object
periods <- tibble(xmin = ymd("2014-05-01", tz = "UTC"), xmax = ymd("2014-08-01", tz = "UTC"), fill = "red")

base + geom_rect(data = periods, aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = fill), alpha = 0.3)



res <- mutate(data_for_test_b, positive_tv = (TV > 0), period_tv_id = rleid(positive_tv), 
              positive_ooh = (OOH_daily > 0), period_ooh_id = rleid(positive_ooh))
# attempt a

periods_tv <- group_by(res, period_tv_id) %>% filter(positive_tv == TRUE) %>% 
  summarise(xmin = first(Date), xmax = last(Date), average = mean(TV), info = "positive_tv")

periods_ooh <- group_by(res, period_ooh_id) %>% filter(positive_ooh == TRUE) %>% 
  summarise(xmin = first(Date), xmax = last(Date), average = mean(OOH_daily), info = "positive_ooh")

periods <- bind_rows(periods_tv, periods_ooh)

base + geom_rect(data = periods, aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = info), alpha = 0.3) 


# attempt b

periods_from_id <- function(df_with_id, id_variable, date_variable, info) {
  id_variable <- enquo(id_variable)
  date_variable <- enquo(date_variable)
  periods <- group_by(df_with_id, !!id_variable) %>% 
    summarise(xmin = first(!!date_variable), xmax = last(!!date_variable), info = info) %>%
    select(-!!id_variable)
  return(periods)
} 

periods_tv <- periods_from_id(filter(res, TV > 0), period_tv_id, Date, info = "tv")
periods_ooh <- periods_from_id(filter(res, OOH_daily > 0), period_ooh_id, Date, info = "ooh")

periods <- bind_rows(periods_tv, periods_ooh)
base + geom_rect(data = periods, aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = info), alpha = 0.3) 
