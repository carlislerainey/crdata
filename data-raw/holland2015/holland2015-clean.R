
# load packages
library(tidyverse)

# set seed
set.seed(8904)

# load data
holland2015 <- haven::read_dta("data-raw/holland2015/Enforcement.dta") %>%
  # keep only the variables we use
  select(city, district, operations, lower, vendors, budget, population) %>%
  glimpse()

usethis::use_data(holland2015, overwrite = TRUE)

# write to inst/extdata
write_csv(holland2015, "inst/extdata/holland2015.csv")
write_rds(holland2015, "inst/extdata/holland2015.rds")

# load data
holland <- crdata::holland2015

# table of observations per city
table(holland$city)

# formula corresponds to model 1 for each city in holland (2015) table 2
f <- operations ~ lower + vendors + budget + population

# fit poisson regression model for Santiago
fit <- glm(f, family = poisson, data = holland, subset = city == "santiago")
summary(fit)
