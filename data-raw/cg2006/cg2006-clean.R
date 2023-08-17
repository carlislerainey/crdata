
# raw: Legislative_new.dta
# source: Clark and Golder (2006)
# url: https://hdl.handle.net/1902.1/10477

# load packages
library(tidyverse)
library(haven)

# read raw data
cg <- read_dta("data-raw/cg2006/Legislative_new.dta")

## delete cases following Clark and Golder's .do file
### no recognizable parties
cg <- cg[cg$countrynumber != 163, ]
cg <- cg[cg$countrynumber != 165, ]
cg <- cg[cg$countrynumber != 197, ]
cg <- cg[cg$countrynumber != 189, ]
cg <- cg[cg$countrynumber != 146, ]
cg <- cg[cg$countrynumber != 198, ]
cg <- cg[cg$countrynumber != 167, ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1958), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1960), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1962), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1964), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1966), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1968), ]
cg <- cg[!(cg$countrynumber == 70 & cg$year == 1970), ]
cg <- cg[!(cg$countrynumber == 12 & cg$year == 1963), ]
### drop fused votes
cg <- cg[cg$countrynumber != 67, ]
cg <- cg[cg$countrynumber != 76, ]
cg <- cg[!(cg$countrynumber == 59 & cg$year == 1957), ]
cg <- cg[!(cg$countrynumber == 59 & cg$year == 1971), ]
cg <- cg[!(cg$countrynumber == 59 & cg$year == 1985), ]
cg <- cg[!(cg$countrynumber == 59 & cg$year == 1989), ]
cg <- cg[!(cg$countrynumber == 59 & cg$year == 1993), ]
cg <- cg[!(cg$countrynumber == 57 & cg$year == 1990), ]
cg <- cg[!(cg$countrynumber == 54 & cg$year == 1966), ]
cg <- cg[!(cg$countrynumber == 54 & cg$year == 1970), ]
cg <- cg[!(cg$countrynumber == 54 & cg$year == 1974), ]
cg <- cg[!(cg$countrynumber == 54 & cg$year == 1986), ]
### drop countries with large "others"
cg <- cg[!(cg$enep_others > 15 & cg$enep_others < 100), ]
### drop countries with majoritarian uppers
cg <- cg[cg$countrynumber != 132, ]
cg <- cg[cg$countrynumber != 29, ]
cg <- cg[!(cg$countrynumber == 87 & cg$year == 1988), ]
cg <- cg[!(cg$countrynumber == 87 & cg$year == 1992), ]
cg <- cg[!(cg$countrynumber == 87 & cg$year == 1996), ]
cg <- cg[!(cg$countrynumber == 116 & cg$year == 1987), ]
cg <- cg[!(cg$countrynumber == 116 & cg$year == 1996), ]
### create a country-year variable
cg$country.year <- paste(cg$country, " (", cg$year, ")", sep = "")



f.cg <- enep1 ~ eneg + avemag + uppertier + enpres + proximity1 + country + year + old
df <- model.frame(f.cg, cg) %>%
  # keep only variables of interest
  select(country, year, average_magnitude = avemag, eneg, enep = enep1,
         upper_tier = uppertier, en_pres = enpres, proximity = proximity1, established_democracy = old) %>%
  mutate(established_democracy = established_democracy == 1) %>%
  filter(established_democracy) %>%
  select(-established_democracy) %>%
  # mutate(social_heterogeneity = cut_number(eneg, 3, labels = c("Bottom 3rd of ENEG",
  #                                                              "Middle 3rd of ENEG",
  #                                                              "Top 3rd of ENEG"))) %>%
  # # create factor variable with electoral system
  # mutate(electoral_system = cut(x = average_magnitude,
  #                               breaks = c(-Inf, 1, 7, Inf),
  #                               labels = c(c("Single-Member District",
  #                                            "Small-Magnitude PR",
  #                                            "Large-Magnitude PR")))) %>%
  na.omit()

cg2006 <- df

# Estimate the model
# this replicated Clark and Golder's 1946-2000 Established Democracies model in Table 2 on p 698
m <- lm(enep ~ eneg*log(average_magnitude) + eneg*upper_tier + en_pres*proximity, data = cg2006)

arm::display(m)

usethis::use_data(cg2006, overwrite = TRUE)

write_csv(cg2006, "inst/extdata/cg2006.csv")
write_rds(cg2006, "inst/extdata/cg2006.rds")
