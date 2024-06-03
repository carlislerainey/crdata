
library(tidyverse)

robbins_pilot <- read_rds("data-raw/robbins2024/robbins-pilot.rds") %>%
  glimpse()

robbins_main <- read_rds("data-raw/robbins2024/robbins-main.rds") %>%
  filter(passed_mvc1) %>%
  select(cong_overall, failure, amplify, pid7, pid_strength) %>%
  glimpse()

usethis::use_data(robbins_pilot, overwrite = TRUE)
usethis::use_data(robbins_main, overwrite = TRUE)


# write to inst/extdata
write_csv(robbins_pilot, "inst/extdata/robbins-pilot.csv")
write_rds(robbins_pilot, "inst/extdata/robbins-pilot.rds")
write_csv(robbins_main, "inst/extdata/robbins-main.csv")
write_rds(robbins_main, "inst/extdata/robbins-main.rds")

# load Robbins et al.'s data
#robbins_pilot <- crdata::robbins_pilot
#robbins_main <- crdata::robbins_main

# example analysis

# center control variable at mean
robbins_pilot$rs_pid_strength <- robbins_pilot$pid_strength - mean(robbins_pilot$pid_strength)
robbins_main$rs_pid_strength <- robbins_main$pid_strength - mean(robbins_main$pid_strength)

# fit model to pilot data set
fit_pilot <- lm(cong_overall ~ failure*amplify*rs_pid_strength, data = robbins_pilot)

# fit model to main data set
fit_main <- lm(cong_overall ~ failure*amplify*rs_pid_strength, data = robbins_main)

# "predict" standard error from main data set using pilot data for interaction

# extract needed quantities
n_pilot <- nobs(fit_pilot)/4  # observations per condition
n_main <- nobs(fit_main)/4  # observations per condition
se_hat_pilot <- sqrt(diag(sandwich::vcovHC(fit_pilot, type = "HC2")))["failureFailure:amplifyAmplify"]  # se from pilot

# prediction
sqrt(n_pilot/n_main)*se_hat_pilot

# conservative prediction
sqrt(n_pilot/n_main)*((sqrt(1/(2*n_pilot)) + 1)*se_hat_pilot)

# actual
sqrt(diag(sandwich::vcovHC(fit_main, type = "HC2")))["failureFailure:amplifyAmplify"]  # se from main

# creating a two-group example

# drop success condition
# - treatment: amplify
# - control:   ignore
# (operation always fails)

# drop succes condition
robbins2 <- robbins_main |>
  subset(failure == "Failure")

# t test
t.test(cong_overall ~ amplify, data = robbins2)

