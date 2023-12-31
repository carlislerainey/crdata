#' A data set on enforcement operations; illustrates Poisson regression
#'
#' Holland (2015) data set used in Rainey (2023) to illustrate the difference between the "average-of-simulations" and directly transformed quantities of interest.
#' These are the data to reproduce Model (1) for Bogota, Lima, and Santiago from Holland's Table 2 on p. 368.
#' Note that the coefficients in Table 2 are standardized and exponentiated with (Stata's) robust standard errors.
#'
#' In Rainey (2023), I focus on the following hypothesis:
#'
#' "My first hypothesis is that enforcement operations drop off with the fraction of poor residents in an electoral district.
#' So district poverty should be a negative and significant predictor of enforcement, but only in politically decentralized cities \[Lima and Santiago\].
#' Poverty should have no relationship with enforcement in politically centralized cities \[Bogota\] once one controls for the number of vendors (p. 362)"
#'
#'
#' @format A data frame with 89 district-level observations across three cities:
#' \describe{
#' \item{\code{city}}{the observation's city (Holland performs separate analyses for each city)}
#' \item{\code{district}}{the name of the district (the unit of observation)}
#' \item{\code{operations}}{the number of enforcement operations conducted per month by a district (averaged across three or more months per district)}
#' \item{\code{lower}}{share of lower-class residents in a district}
#' \item{\code{vendors}}{the number of unlicensed street vendors (in thousands)}
#' \item{\code{budget}}{district budget per capita}
#' \item{\code{population}}{district population (unclear scale)}
#' }
#' For further details, see Holland (2015, p. 364) and pp. 3-6 of the file \href{https://onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2Fajps.12125&file=ajps12125-sup-0001-SupMat.docx}{ajps12125-sup-0001-SupMat.docx} available on the journal website.
#'
#'
#' @references
#'
#' Holland, Alisha C. 2015. "The Distributive Politics of Enforcement."
#' \emph{American Journal of Political Science} 59(2): 357–71. \doi{10.1111/ajps.12125}.
#'
#' Holland, Alisha. 2014. "Replication data for: The Distributive Politics of Enforcement." Harvard Dataverse, V2. \doi{10.7910/DVN/24859}.
#'
#'
#' Rainey, Carlisle. 2023. "A Careful Consideration of CLARIFY: Simulation-Induced Bias in Point Estimates of Quantities of Interest."
#' \emph{Political Science Research and Methods}. Forthcoming. \doi{10.1017/psrm.2023.8}.
#'
#'
#' @examples
#'
#' # a simple example
#'
#' # load data
#' holland <- crdata::holland2015
#'
#' # table of observations per city
#' table(holland$city)
#'
#' # formula corresponds to model 1 for each city in holland (2015) table 2
#' f <- operations ~ lower + vendors + budget + population
#'
#' # fit poisson regression model for Santiago
#' fit <- glm(f, family = poisson, data = holland, subset = city == "santiago")
#' summary(fit)
#'
"holland2015"
