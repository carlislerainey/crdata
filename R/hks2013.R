#' A data set on civilian casualties in civil war; illustrates count regressions
#'
#' Hultman, Kathman, and Shannon (2013) data set used in McCaskey and Rainey (2015) to illustrate count regression models,
#' such as Poisson, negative binomial, and their zero-inflated and hurdle variants. These are the data to reproduce the negative binomial regression coefficients for
#' Model 1 in Table 1 on p. 884 of Hultman, Kathman, and Shannon (2013).
#'
#'
#' @format A country-month data frame.
#' \describe{
#' \item{\code{location}}{the country}
#' \item{\code{year}}{the year}
#' \item{\code{mon}}{the month}
#' \item{\code{osvAll}}{the number of civilians killed in a conflict month by any combatant faction}
#' \item{\code{troopLag}}{the number of UN military troops committed to a country in conflict during a given month; lagged one month}
#' \item{\code{policeLag}}{the number of UN police committed to a country in conflict during a given month; lagged one month}
#' \item{\code{militaryobserversLag}}{the number of UN observers committed to a country in conflict during a given month; lagged one month}
#' \item{\code{brv_AllLag}}{the number of all battle deaths; lagged one month}
#' \item{\code{osvAllLagDum}}{whether any civilians were killed by any combatant faction; lagged one month}
#' \item{\code{incomp}}{a dichotomous variable that uses the UCDP/PRIO delineation of civil wars fought over territorial (0) or government (1) control.}
#' \item{\code{epduration}}{the number of months since the beginning of a conflict episode}
#' \item{\code{lntpop}}{the country's logged population size}
#' }
#' For further details, see Hultman, Kathman, and Shannon (2013) pp. 883-884 and Kathman (2013).
#'
#'
#' @references
#'
#' Hultman, Lisa, Jacob Kathman, and Megan Shannon. 2013.
#' "United Nations Peacekeeping and Civilian Protection in Civil War."
#' \emph{American Journal of Political Science} 57(4): 875–91. \doi{10.1111/ajps.12036}.
#'
#' Hultman, Lisa, Jacob Kathman, and Megan Shannon. 2013.
#' "Replication data for: United Nations Peacekeeping and Civilian Protection in Civil War."
#' Harvard Dataverse, V3. \doi{10.7910/DVN/6EBCGA}.
#'
#' Kathman, Jacob D. 2013.
#' "United Nations Peacekeeping Personnel Commitments, 1990–2011."
#' \emph{Conflict Management and Peace Science} 30(5): 532–49. \doi{10.1177/0738894213491180}.
#'
#' McCaskey, Kelly, and Carlisle Rainey. 2015.
#' "Substantive Importance and the Veil of Statistical Significance."
#' \emph{Statistics, Politics and Policy} 6(1–2). \doi{10.1515/spp-2015-0001}.
#'
#'
#' @examples
#'
#' # a simple example
#'
#' # load data in a way that mirrors read.csv(), etc.
#' hks <- crdata::hks2013
#'
#' # estimate models
#' f <- osvAll ~ troopLag + policeLag + militaryobserversLag +
#'   brv_AllLag + osvAllLagDum + incomp + epduration +
#'   lntpop
#'
#' # replicates model 1 in table 1 on p. 884 of HKS
#' # m2 <- MASS::glm.nb(f, data = hks2013,
#' #                    init.theta = 5,
#' #                    control = glm.control(epsilon = 1e-12,
#' #                                          maxit = 2500,
#' #                                          trace = FALSE))
#' # summary(m2) # compare to p. 884
#'
#' # a poisson alternative to the above
#' m1 <- glm(f, data = hks2013, family = "poisson")
#' summary(m1)
#'
#'
"hks2013"
