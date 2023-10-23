#' A data set on MID onset; illustrates logistic regression
#'
#' Russett and Oneal (2001) data set used in Rainey (2016) to illustrate compression in logistic regression models.
#' These are the data to reproduce the logistic regression coefficients in Table 2 on p. 11 of the \href{https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S204984701500059X/resource/name/S204984701500059Xsup001.pdf}{Appendix to Rainey (2016)}.
#' Note that I've altered the coding of some variables, so the coefficients won't replicate exactly.
#'
#'
#' @format A dyad-year data set.
#' \describe{
#' \item{\code{statea}}{the first state in the dyad}
#' \item{\code{stateb}}{the second state in the dyad}
#' \item{\code{stateaname}}{the name of first state in the dyad; created with countrycode}
#' \item{\code{statebname}}{the second state in the dyad; created with countrycode}
#' \item{\code{year}}{the year}
#' \item{\code{dispute}}{a factor variable indicating the onset of conflict, specifically the onset of a militarized interstate dispute}
#' \item{\code{allies}}{a factor variable indicating whether the members of the dyad are allies or not. Allies are linked by a mutual defense treaty, neutrality pact, or entente.}
#' \item{\code{lcaprat2}}{the logged ratio of the stronger state's military capability index to that of the weaker member}
#' \item{\code{contiguity}}{factor variable indicating whether the members of the dyad are contiguous or not}
#' \item{\code{dem.lo}}{the smaller of the two Polity IV scores in the dyad}
#' \item{\code{logdstab}}{the logged number of miles between the capitals}
#' \item{\code{power}}{factor variable indicating whether the dyad is minor powers or at least one member is a great power.}
#' }
#'
#' @references
#'
#' Russett, Bruce, and John R. Oneal. 2001. \emph{Triangulating Peace: Democracy, Interdependence, and International Organizations}. New York: W. W. Norton.
#'
#' Rainey, Carlisle. 2016. "Compression and Conditional Effects: A Product Term Is Essential When Using Logistic Regression to Test for Interaction."
#' \emph{Political Science Research and Methods} 4(3): 621–39. \doi{0.1017/psrm.2015.59}.
#'
#' Rainey, Carlisle. 2015. "Replication Data for: Compression and Conditional Effects." \doi{10.7910/DVN/ASSC0Y}.
#'
#'
#' @examples
#'
#' # a simple example
#'
#' ro <- crdata::oro001
#'
#' # glm version of their gee on pp. 314 with no product term
#' m.noprod <- glm(dispute ~ allies + lcaprat2 + contiguity + dem.lo + logdstab + power,
#'                 family = "binomial", data = ro)
#'
#' # glm version of their gee on pp. 314 with no product terms
#' m.prod <- glm(dispute ~ allies + lcaprat2 + contiguity + dem.lo*logdstab + power,
#'               family = "binomial", data = ro)
#'
#'
#' # there are no non-contiguous minor powers in this data set
#' table(ro$contiguity, ro$power)
#'
#'
"ro2001"
