#' A data set on guerrilla resistance; illustrates logistic regression with a small sample
#'
#' Weisiger (2014) data set used in Rainey and McCaskey (2021) to illustrate Firth's (1993) penalized maximum likelihood estimator. These are the data to reproduce Model 3 in Table 2 on p. 370.
#'
#' @format A data frame with 35 observations and seven variables:
#' \describe{
#' \item{\code{resist}}{whether conquest is followed by significant guerrilla resistance}
#' \item{\code{polity_conq}}{conqueror’s Polity score}
#' \item{\code{lndist}}{intercapital distance, logged}
#' \item{\code{terrain}}{the percentage of a conquered country’s territory that is mountainous}
#' \item{\code{soldperterr}}{the density of the occupying force, which is calculated by dividing force size by the area of the conquered country}
#' \item{\code{gdppc2}}{gross domestic product (GDP) per capita}
#' \item{\code{coord}}{whether the pre-conquest political leader of the country, who forms the most natural leader for any guerrilla resistance, remained free to operate in the country}
#' }
#' For further details, see Weisiger (2014, pp. 365-366).
#'
#'
#' @references
#'
#' Firth, David.
#' 1993.
#' "Bias Reduction of Maximum Likelihood Estimates."
#' \emph{Diometrika} 80(1): 27-38.
#' \doi{10.1093/biomet/80.1.27}
#'
#' Rainey, Carlisle and Kelly McCaskey.
#' 2021.
#' "Estimating Logit Models with Small Samples.
#' \emph{Political Science Research and Methods} 9(3): 549-564.
#' \doi{10.1017/psrm.2021.9}
#'
#' Weisiger, Alex.
#' 2014.
#' "Victory Without Peace: Conquest, Insurgency, and War Termination."
#' \emph{Conflict Management and Peace Science} 31(4): 357–382. \doi{10.1177/0738894213508691}
#'
#' Weisiger, Alex. 2014.
#' "conq_ins_data.tab." \emph{Replication data for: Victory without Peace: Conquest, Insurgency, and War Termination}.,
#'  Harvard Dataverse, V1. \doi{10.7910/DVN/OPCGOE/Q40MGO}
#'
#'
#' @examples
#'
#' # a simple example
#'
#' weis <- crdata::weisiger2014
#'
#' # formula for Model 3 in Table 2 of Weisiger (2014)
#' f <- resist ~ polity_conq + lndist + terrain + soldperterr + gdppc2 + coord
#'
#' # reproduce Weisiger's LPM estimates
#' ls <- lm(f, data = weis) # linear probability model
#' summary(ls)
#'
#' # fit a logit model
#' mle <- glm(f, data = weis, family = "binomial") # logistic regression
#' summary(mle)
#'
"weisiger2014"
