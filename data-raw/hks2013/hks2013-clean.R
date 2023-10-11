
# clear workspace
rm(list = ls())

# load packages
library(tidyverse)

# read data
hks2013 <- read.csv("data-raw/hks2013/HKS_AJPS_2013.tab", sep = "\t") |>
  glimpse()
keep <- c("location", "year", "mon", "osvAll", "troopLag", "policeLag", "militaryobserversLag",
          "brv_AllLag", "osvAllLagDum", "incomp", "epduration", "lntpop")
hks2013 <- na.omit(hks2013[, keep])


usethis::use_data(hks2013, overwrite = TRUE)

# write to inst/extdata
write_csv(hks2013, "inst/extdata/hks2013.csv")
write_rds(hks2013, "inst/extdata/hks2013.rds")

# estimate models
f <- osvAll ~ troopLag + policeLag + militaryobserversLag +
  brv_AllLag + osvAllLagDum + incomp + epduration +
  lntpop

# replicates model 1 in table 1 on p. 884 of HKS
m2 <- MASS::glm.nb(f, data = hks2013,
                   init.theta = 5,
                   control = glm.control(epsilon = 1e-12,
                                         maxit = 2500,
                                         trace = FALSE))

# a poisson alternative to the above
m1 <- glm(f, data = hks2013, family = "poisson")

# a zero-inflated alternative
m3 <- pscl::zeroinfl(f, data = hks2013, dist = "negbin")

# compare models
AIC(m1, m2, m3)

modelsummary::modelsummary(m2)
