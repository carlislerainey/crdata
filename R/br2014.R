#' A data set on governors' opposition to Medicaid expansion under the ACA; illustrates logistic regression with separation in small samples
#'
#' A data set containing the \emph{rescaled} variables that Barrilleaux and Rainey (2014) use in
#' the their main statistical model of governors' decisions to oppose the
#' Medicaid expansion under the Affordable Care Act. Most importantly, no Democratic governors
#' opposed the expansion, leading to a problem of separation. Numeric variables are rescaled to have a mean of
#' 0 and an SD of 0.5; binary variables are rescaled to have a mean of 0. This data set is used in Figure 2 on p. 446 of Barrilleaux and Rainey (2014).
#'
#' @format A data frame with 50 observations of \emph{rescaled} versions of the following
#' 10 variables: \describe{
#'   \item{state}{the name of the state}
#'   \item{oppose_expansion}{equals one if
#'   the state's governor opposed the expansion and zero otherwise; outcome variable, so not rescaled}
#'   \item{gop_governor}{equals one if the state's governor is Republican and
#'   zero otherwise}
#'   \item{percent_favorable_aca}{an estimate of the percent of
#'   the state's population that views the ACA favorably}
#'   \item{gop_leg}{equals one if Republicans control both houses of the state
#'   legislature and zero otherwise}
#'   \item{percent_uninsured}{the percent of the
#'   state's population without health insurance}
#'   \item{bal2012}{the state's
#'   year-end reserves as a percentage of total spending for 2012}
#'   \item{multiplier}{the state's current Medicaid multiplier}
#'   \item{percent_nonwhite}{the percent of the state that is non-white}
#'   \item{percent_metro}{the percent of the state that resides in a
#'   metropolitan area}}
#'
#' For further details, see Barrilleaux and Rainey (2014, pp. 444-445).
#'
#' @references
#'
#'   Barrilleaux, Charles, and Carlisle Rainey. 2014. "The Politics of Need: Examining Governors' Decisions to Oppose the 'Obamacare' Medicaid Expansion."
#'   \emph{State Politics and Policy Quarterly} 14(4): 437–60. \doi{10.1177/1532440014561644}.
#'
#'   Barrilleaux, Charles, and Carlisle Rainey. 2014. "politics_and_need_rescale.csv."
#'   \emph{Replication data for: "The Politics of Need: Examining Governors’ Decisions to Oppose the ‘Obamacare’ Medicaid Expansion"}. UNC Dataverse, V1.  \doi{10.15139/S3/12130}.
#'
#' Rainey, Carlisle. 2016.
#' "Dealing with Separation in Logistic Regression Models." \emph{Political Analysis} 24(3): 339-355. \doi{10.1093/pan/mpw014}.
#'
#'  Rainey, Carlisle. 2023.
#' "Hypothesis Tests Under Separation." Forthcoming in \emph{Political Analysis}. \doi{10.31235/osf.io/bmvnu}.
#'
#' @examples
#'
#' # a simple example
#'
#' br <- crdata::br2014
#'
#' # formula to reproduce Figure 2 on p. 446 of Barrilleaux and Rainey (2014).
#' f <- oppose_expansion ~ gop_governor +  percent_favorable_aca +  gop_leg +
#'  percent_uninsured + bal2012 + multiplier + percent_nonwhite + percent_metro
#'
#' # gop_governor == 0 perfectly predicts oppose_expansion == 0
#' table("oppose_expansion" = br$oppose_expansion,
#'       "gop_governor" = br$gop_governor)
#'
#' # logit model with separation
#' fit <- glm(f, data = br, family = binomial)
#'
#' # Rainey (2023) shows that Wald tests can never reject null when variables
#' #   create separation
#' summary(fit)
#'
#' # Rainey (2023) shows that the LR test works fine when variables create
#' #   separation, though.
#' fit0 <- update(fit, . ~ . - gop_governor)
#' anova(fit0, fit, test = "Chisq")
#'
#'
#'
"br2014"
