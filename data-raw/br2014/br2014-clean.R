
library(tidyverse)


raw <- read_csv("data-raw/br2014/politics_and_need_rescale.csv") %>%
  glimpse()

br2014 <- raw %>%
  select(state, oppose_expansion, gop_governor, percent_favorable_aca, gop_leg, percent_uninsured,
         bal2012, multiplier, percent_nonwhite, percent_metro)

usethis::use_data(br2014, overwrite = TRUE)

write_csv(br2014, "inst/extdata/br2014.csv")
write_rds(br2014, "inst/extdata/br2014.rds")
