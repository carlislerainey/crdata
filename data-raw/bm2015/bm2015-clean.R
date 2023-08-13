

# load data set
d <- read.csv("data-raw/bm2015/bm.csv") %>%
  glimpse()

d <- d[, c("year", "statea", "stateb", "warl2", "onenukedyad", "twonukedyad", "logCapabilityRatio", "Ally",
           "SmlDemocracy", "SmlDependence", "logDistance", "Contiguity",
           "MajorPower", "NIGOs")]

bm2015 <- na.omit(d)

usethis::use_data(bm2015, overwrite = TRUE)

write_csv(bm2015, "inst/extdata/bm2015.csv")
write_rds(bm2015, "inst/extdata/bm2015.rds")

glimpse(bm2015)

#rs_d <- d %>%
#  mutate(across(onenukedyad:NIGOs, arm::rescale))

#
# # set formula
# f <- warl2 ~ onenukedyad + twonukedyad + logCapabilityRatio +
#   Ally + SmlDemocracy + SmlDependence + logDistance +
#   Contiguity + MajorPower + NIGOs
#
# library(tidyverse)
# library(brglm2)
# library(logistf)
# library(microbenchmark)
#
# f0 <- function() {
#   lm(f, data = rs_d)
# }
# f1 <- function() {
#   glm(f, data = rs_d, family = "binomial")
# }
# f2 <- function() {
#   glm(f, data = rs_d, family = "binomial", method = brglmFit, maxit = 1000,
#       start = coef(lm(f, data = rs_d)))
# }
# f3 <- function() {
#   logistf(f, data = rs_d)
# }
# f4 <- function() {
#   logistf(f, data = rs_d, pl = FALSE)
# }
#
# # do benchmarking
# bm <- microbenchmark("least squres" = f0(),
#                      "regular glm()" = f1(),
#                      "brglm2" = f2(),
#                      "logistf (default)" = f3(),
#                      "logistf (w/ pl = FALSE)" = f4(),
#                      times = 2,
#                      control = list(warmup = 1))
# print(bm)
