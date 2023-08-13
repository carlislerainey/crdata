#' A data set on nuclear weapons and war; illustrates logistic regression with separation in a large sample
#'
#' Bell and Miller (2015) data set used in Rainey (2016) and Rainey (2023) to illustrate logistic regression models with separation. These are the data to reproduce the "Firth logit" results with "Kargil excluded" throughout Bell and Miller (2015). See the "Firth logit" column of Table B of their online appendix.
#'
#' @format A data frame with 455,619 observations and 14 variables:
#' \describe{
#' \item{\code{year}}{the year of the observation (i.e., dyad-year)}
#' \item{\code{statea}}{the numeric COW code of the first state of the dyad}
#' \item{\code{stateb}}{the numeric COW code of the second state of the dyad}
#' \item{\code{warl2}}{whether a war occurred}
#' \item{\code{onenukedyad}}{whether exactly one state has nuclear weapons}
#' \item{\code{twonukedyad}}{whether both states have nuclear weapons}
#' \item{\code{logCapabilityRatio}}{the natural log of the capability ratio, which measures the distribution of power between the two states}
#' \item{\code{Ally}}{whether the two states have a formal alliance or nonaggression pact}
#' \item{\code{SmlDemocracy}}{the smaller of the two Polity scores in the dyad}
#' \item{\code{SmlDependence}}{measures economic interdependence; the smaller of each country's imports and exports with its partner divided by their GDP}
#' \item{\code{logDistance}}{the natural log of the distance between capitals of two states, or for large states, the distance between nearest ports}
#' \item{\code{Contiguity}}{whether the two states are continguous}
#' \item{\code{MajorPower}}{whether at least one of the states is a major power}
#' \item{\code{NIGOs}}{measures shared membership in intergovernmental organizations}
#' }
#' For further details, see Rauchhaus (2009, pp. 266-268) and Pevehouse and Russett (2006, pp. 980-983).
#'
#'
#' @references
#'
#' Bell, Mark S., and Nicholas L. Miller. 2013.
#' "Questioning the Effect of Nuclear Weapons on Conflict."
#' \emph{Journal of Conflict Resolution} 59(1): 74–92. \doi{10.1177/0022002713499718}.
#'
#' Pevehouse, Jon, and Bruce Russett.
#' 2006.
#' "Democratic International Governmental Organizations Promote Peace."
#' \emph{International Organization} 60(4): 969-1000.
#' \doi{10.1017/S0020818306060322}.
#'
#'
#' Rainey, Carlisle. 2016.
#' "Dealing with Separation in Logistic Regression Models." \emph{Political Analysis} 24(3): 339-355. \doi{10.1093/pan/mpw014}.
#'
#'  Rainey, Carlisle. 2023.
#' "Hypothesis Tests Under Separation." Forthcoming in \emph{Political Analysis}. \doi{10.31235/osf.io/bmvnu}.
#'
#' Rainey, Carlisle.
#' 2016.
#' "priors-for-separation.zip"
#' Replication Data for: Dealing with Separation in Logistic Regression Models. Harvard Dataverse, V1. \doi{10.7910/DVN/VW7G2Q/MTJB9H}.
#'
#' Rauchhaus, Robert. 2009. "Evaluating the Nuclear Peace Hypothesis."
#' \emph{Journal of Conflict Resolution} 53(2): 258–77. \doi{10.1177/0022002708330387}.
#'
#'
#' @examples
#'
#' # a simple example
#'
#' bm <- crdata::bm2015
#'
#' # formula to reproduce "Firth logit" column of Table B of Bell and Miller's online appendix.
#' f <- warl2 ~ onenukedyad + twonukedyad + logCapabilityRatio +
#'   Ally + SmlDemocracy + SmlDependence + logDistance +
#'   Contiguity + MajorPower + NIGOs
#'
#' # twonukedyad == 1 perfectly predicts warl2 == 0
#' table("warl2" = bm$warl2, "twonukedyad" = bm$twonukedyad)
#'
#' # logit model with separation
#' fit <- glm(f, data = bm, family = binomial)
#'
#' # Rainey (2023) shows that Wald tests can never reject null when variables
#' #   create separation
#' summary(fit)
#'
#' # Rainey (2023) shows that the LR test works fine when variables create
#' #   separation, though.
#' fit0 <- update(fit, . ~ . - twonukedyad)
#' anova(fit0, fit, test = "Chisq")
#'
#'
"bm2015"
