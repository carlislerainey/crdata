
<!-- README.md is generated from README.Rmd. Please edit that file -->

# crdata

<!-- badges: end -->

The goal of {crdata} is to provide easy access to data I’ve used in
research and teaching, and its documentation.

## Minimal Example

Here’s a minimal example to illustrate the recommended use.

``` r
# install package (once per computer)
# remotes::install_github("carlislerainey/crdata")

# load data (once per session)
weis <- crdata::weisiger2014

# open documentation (as needed)
?crdata::weisiger2014
```

## Installing the Package

To install the development version from
[GitHub](https://github.com/carlislerainey/crdata) use:

    # install latest crdata package from github
    # install.packages("remotes")
    remotes::install_github("carlislerainey/crdata")

I have no plans at the moment to upload to CRAN.

## Data Sets

| Data Set       | References                                                                                                                                                                                                                                   | Topics                                                                                  |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| `bm2015`       | [Rauchhaus(2009)](https://doi.org/10.1177/0022002708330387); [Bell and Miller (2015)](https://doi.org/10.1177/0022002713499718); [Rainey (2016)](https://doi.org/10.1093/pan/mpw014); [Rainey (2023)](https://doi.org/10.31235/osf.io/bmvnu) | Logistic regression with separation in large samples.                                   |
| `br2014`       | [Barrilleaux and Rainey (2014)](https://doi.org/10.1177/1532440014561644); [Rainey (2016)](https://doi.org/10.1093/pan/mpw014); [Rainey (2023)](https://doi.org/10.31235/osf.io/bmvnu)                                                       | Logistic regression with separation in small samples.                                   |
| `cg2006`       | [Clark and Golder (2006)](https://doi.org/10.1177/0010414005278420); [Rainey (2014)](https://doi.org/10.1111/ajps.12102); [Baissa and Rainey (2018)](https://doi.org/10.1017/psrm.2018.34)                                                   | Linear regression, equivalence testing, interaction, non-normal residuals, outliers     |
| `hks2013`      | [Hultman, Kathman, and Shannon (2013)](https://doi.org/10.1111/ajps.12036); [Rainey (2023)](https://doi.org/10.1017/psrm.2023.8)                                                                                                             | Poisson regression, predictive distribution, overdispersion, information criteria       |
| `holland2015`  | [Holland (2015)](https://doi.org/10.1111/ajps.12125); [McCaskey and Rainey (2015)](https://doi.org/10.1515/spp-2015-0001)                                                                                                                    | Poisson regression, predictive distribution, overdispersion, information criteria       |
| `ro2001`       | [Russett and Oneal (2001)](https://www.amazon.com/Triangulating-Peace-Interdependence-International-Organizations/dp/039397684X); [Rainey (2016)](https://doi.org/10.1017/psrm.2015.59)                                                      | logistic regression, compression                                                        |
| `weisiger2014` | [Weisiger (2014)](https://journals.sagepub.com/doi/10.1177/0738894213508691); [Rainey and McCaskey (2021)](https://doi.org/10.1017/psrm.2021.9)                                                                                              | Logistic regression in small samples; Firth’s logit; R packages {brglm2} and {logistf}. |

## Using the Data

There are three ways to access the data. I’ll illustrate the syntax with
the `weisiger2014` data set.

1.  **Recommended**: First, you can use `weis <- crdata::weisiger2014`.
    I prefer this approach because it mirrors `weis <- read_csv(path)`
    most closely.
2.  Second, you can refer to the data set with the `::` operators
    without creating an object. Anytime you want to use the
    `weisiger2014` data set, simply use `crdata::weisiger2014`.
3.  Third, you can run `library(crdata)`, which lazily loads all the
    data sets, so that `weisiger2014` (and all others) are available
    without the `crdata::` prefix.

To see the documentation, run `?crdata::weisiger2014`.

## Example

For example, McCaskey and Rainey (2021) uses data from Weisiger (2014)
to illustrate Firth’s logit using a binary outcome in small samples.
Here’s a comparison of logit models fit using maximum likelihood and
Firth’s penalized maximum likelihood.

``` r
# load packages
library(tidyverse)

# load data
weis <- crdata::weisiger2014

# rescale weisiger2014 explanatory variables using arm::rescale()
rs_weis <- weis %>%
  mutate(across(polity_conq:coord, arm::rescale)) 

# fit models
f <- resist ~ polity_conq + lndist + terrain + soldperterr + gdppc2 + coord
ls <- lm(f, data = rs_weis) # lpm (replicates Table 2 Model 3 of Weisiger 2014)
mle <- glm(f, data = rs_weis, family = "binomial") # logistic regression
pmle <- glm(f, data = rs_weis, family = "binomial", method = brglm2::brglmFit) # logistic regression


# plot coefficients
modelsummary::modelplot(list("Logit via MLE" = mle, 
                             "Logit via Firth's PMLE" = pmle), 
                        conf_level = 0.90)
```

<img src="man/figures/README-setup-1.png" width="75%" style="display: block; margin: auto;" />

## Citation

Please cite the authors of the original data (both the data set and the
article)! The appropriate references to papers and data sets are given
in the help file for each data set (e.g., `?crdata::weisiger2014`).
