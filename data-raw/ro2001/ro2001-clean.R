
library(tidyverse)

country_names <- countrycode::codelist_panel |>
  select(cown, year, country.name = country.name.en) |>
  glimpse()

# Data available at
#   http://pantheon.yale.edu/~brusset/io_dta.zip
ro2001 <- foreign::read.dta("data-raw/ro2001/or.dta") |>
  mutate(dem.lo = pmin(demauta, demautb)) |>
  #mutate(stateaname = countrycode::countrycode(statea, origin = "cown", destination = "country.name")) |>
  #mutate(statebname = countrycode::countrycode(stateb, origin = "cown", destination = "country.name")) |>
  left_join(country_names, by = join_by(statea == cown, year == year)) |>
  rename(stateaname = country.name) |>
  left_join(country_names, by = join_by(stateb == cown, year == year)) |>
  rename(statebname = country.name) |>
  mutate(contiguity = case_when(noncontg == 0 ~ "Noncontiguous",
                              noncontg == -1 ~ "Contiguous"),
         contiguity = factor(contiguity)) |>
  mutate(power = case_when(minrpwrs == 0 ~ "Minor Powers",
                                minrpwrs == -1 ~ "At Least One Great Power"),
         power = factor(power)) |>
  mutate(allies = case_when(allies == 0 ~ "Not Allies",
                            allies == 1 ~ "Allies"),
         allies = factor(allies)) |>
  mutate(dispute = case_when(dispute1 == 1 ~ "Dispute",
                            dispute1 == 0 ~ "No Dispute"),
         dispute = factor(dispute, levels = c("No Dispute", "Dispute"))) |>
  select(stateaname, statebname, statea, stateb, year, dispute, dispute, allies, lcaprat2, contiguity,
         dem.lo, logdstab, power) |>
  glimpse()

usethis::use_data(ro2001, overwrite = TRUE)


# write to inst/extdata
write_csv(ro2001, "inst/extdata/ro2001.csv")
write_rds(ro2001, "inst/extdata/ro2001.rds")
