#' A data set on electoral institutions and the number of political parties; illustrates negligible effects (or equivalence tests) and non-normal residuals
#'
#' A data set to reproduce Clark and Golder's "Established Democracies 1946-2000" model in Table 2 on p. 698. I use these data as an example of arguing for a negligible
#' effect or equivalence testing (Rainey 2014) and as an example of regression models with non-normal errors (Baissa and Rainey 2018).
#'
#' @format A data frame with 50 observations of \emph{rescaled} versions of the following
#' 10 variables: \describe{
#'   \item{country}{the name of the country that held the election}
#'   \item{year}{the year of the election}
#'   \item{average_magnitude}{the average of the district magnitude (the number of seats available in the district) across all the districts in the country}
#'   \item{enep}{a measure of the \emph{effective} number of political parties in the system. Calculated as \eqn{ENEP_j = \dfrac{1}{\sum_{i = 1}^n v_{ij}^2}}, where \eqn{ENEP_j} represents the effective number of electoral parties in election \eqn{j} and \eqn{v_{ij}} represents the \emph{vote share} (as a proportion) for party \eqn{i} in election \eqn{j}. This particular variable is the effective number of electoral parties once the "other" category has been "corrected" by using the least component method of bounds suggested by Taagepera (1997).}
#'   \item{eneg}{a measure of the \emph{effective} number of ethnic groups in the system. Calculated analogously to ENEP.}
#'   \item{upper_tier}{the percentage of all legislative seats allocated in electoral districts above the lowest electoral tier.}
#'   \item{en_pres}{a measure of the \emph{effective} number of presidential candidates. Calculated analogously to ENEP.}
#'   \item{proximity}{a measure of the temporal proximity of presidential and legislative elections. Calculated as
#'   \eqn{2 \times \lvert \frac{L_t - P_{t - 1}}{P_{t + 1} - P_{t - 1}} - 0.5\rvert}, where \eqn{L_t} is the year of the
#'   legislative election, \eqn{P_{t–1}} is the year of the previous presidential election, and \eqn{P_{t+1}} is the year of the
#'   next presidential election.}
#'   }
#'
#'
#' @references
#'
#' Baissa, Daniel K., and Carlisle Rainey. 2018. "When BLUE Is Not Best: Non-Normal Errors and the Linear Model." \emph{Political Science Research and Methods} 8(1): 136–48. \doi{10.1017/psrm.2018.34}.
#'
#' Clark, William Roberts, and Matt Golder. 2006. "Rehabilitating Duverger’s Theory." \emph{Comparative Political Studies} 39(6): 679–708. \doi{10.1177/0010414005278420}.
#'
#' Clark, William and Matt Golder. 2007. "Legislative_new.tab." \emph{Replication data for: Rehabilitating Duverger's Theory: Testing the Mechanical and Strategic Modifying Effects of Electoral Laws}. \doi{10.7910/DVN/HGXPHP/SVLIF1}.
#' Harvard Dataverse, V1.
#'
#' Rainey, Carlisle. 2014. "Arguing for a Negligible Effect." \emph{American Journal of Political Science} 58(4): 1083–91. \doi{10.1111/ajps.12102}.
#'
#' Rainey, Carlisle. 2013. "cg.csv." \emph{Replication data for: Arguing for a Negligible Effect}. Harvard Dataverse, V2. \doi{10.7910/DVN/23818/TZW36U}.
#'
#' @examples
#'
#' # a simple example
#'
#' # load Clark and Golder's data
#' cg <- crdata::cg2006
#'
#' # reproduce Clark and Golder's 1946-2000 Established Democracies model in Table 2 on p. 698
#' f <- enep ~ eneg*log(average_magnitude) + eneg*upper_tier + en_pres*proximity
#' fit <- lm(f, data = cg)
#' summary(fit)
#'
#' # QQ-plot of residuals
#' qqnorm(residuals(fit))
#'
#'
"cg2006"
