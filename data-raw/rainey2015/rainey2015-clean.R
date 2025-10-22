
# load packages
library(tidyverse)

# set seed
set.seed(8904)

# load data
rainey2015 <- readr::read_csv("data-raw/rainey2015/rainey_ld.csv") %>%
  mutate(district = paste0(Alpha.Polity, "; District ", District),
         electoral_rules = case_when(PR == 1 ~ "PR",
                                     PR == 0 ~ "SMD"),
         electoral_rules = factor(electoral_rules),
         contacted = case_when(Contacted == 1 ~ "Contacted",
                               Contacted == 0 ~ "Not Contacted"),
         contacted = factor(contacted, levels = c("Not Contacted", "Contacted"))) %>%
  # keep only the variables we use
  select(election_id = Alpha.Polity,
         district_id = district,
         contacted,
         district_competitiveness = District.Competitiveness,
         electoral_rules) %>%
  glimpse()

finland <- rainey2015 %>%
  filter(election_id == "Finland") %>%
  select(district_id, contacted) %>%
  mutate(district_id = str_remove(district_id, "Finland; ")) %>%
  glimpse()

uk <- rainey2015 %>%
  filter(election_id == "Great Britain") %>%
  select(district_id, contacted, district_competitiveness) %>%
  mutate(district_id = str_remove(district_id, "Great Britain; ")) %>%
  glimpse()



usethis::use_data(rainey2015, overwrite = TRUE)
usethis::use_data(finland, overwrite = TRUE)
usethis::use_data(uk, overwrite = TRUE)

# write to inst/extdata
write_csv(rainey2015, "inst/extdata/rainey2015.csv")
write_rds(rainey2015, "inst/extdata/rainey2015.rds")
write_csv(finland, "inst/extdata/finland.csv")
write_rds(finland, "inst/extdata/finland.rds")
write_csv(uk, "inst/extdata/uk.csv")
write_rds(uk, "inst/extdata/uk.rds")






# load data
rainey <- crdata::rainey2015

# table of observations per election
table(rainey$election_id)

# fit logit model
f <- contacted ~ district_competitiveness * electoral_rules
fit <- glm(f, family = binomial, data = rainey2015)
summary(fit)
