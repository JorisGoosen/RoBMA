% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{plot.RoBMA}
\alias{plot.RoBMA}
\title{Plots a fitted RoBMA object}
\usage{
\method{plot}{RoBMA}(
  x,
  parameter,
  type = "averaged",
  plot_type = "base",
  mean = TRUE,
  median = FALSE,
  CI = 0.95,
  prior = FALSE,
  order = NULL,
  digits_estimates = 2,
  show_figures = if (parameter == "omega" & (weights | any(type \%in\% "individual")))
    -1,
  weights = FALSE,
  ...
)
}
\arguments{
\item{x}{a fitted RoBMA object}

\item{parameter}{a parameter to be plotted. Either
\code{"mu"}, \code{"tau"}, \code{"theta"}, or
\code{"omega"}. A bivariate plot for model-averaged
estimates of "mu" and "tau" can be obtained by
\code{c("mu","tau")} if \code{type = "averaged"}. In
addition, a forest plot with the original estimates can
be obtained by \code{"forest"} or added to the theta
estimates by \code{c("theta", "forest")}.}

\item{type}{what type of estimates should be plotted.
Options are \code{"averaged"} for the model-averaged
estimates, \code{"conditional"} for the conditional
estimates, or \code{"individual"} for the
individual models estimates. The options
\code{c("individual", "conditional")} can be supplied
together to show only coditional individual models.}

\item{plot_type}{whether to use a base plot \code{"base"}
or ggplot2 \code{"ggplot2"} for plotting. The later
requires \pkg{ggplot2} package to be installed.}

\item{mean}{whether the mean should be plotted.}

\item{median}{whether the median should be plotted.}

\item{CI}{width of the confidence intervals.}

\item{prior}{add prior density to the plot. Only available
for \code{type = "averaged"} or \code{type = "conditional"}.
Defaults to \code{FALSE}.}

\item{order}{either (1) ordering of the studies for
\code{parameter = "theta"} or \code{parameter = "forest"}.
Defaults to \code{NULL} - ordering as supplied to the fitting
function. However, studies can be ordered either
\code{"ascending"} or \code{"descending"} by effect size, or
by \code{"alphabetical"} by labels.
Or (2) ordering models for \code{type = "individual"}. The
default orders models according to their number. However,
models can be ordered either \code{"ascending"} or
\code{"descending"} by posterior model probability
\code{c("ascending", "prob")}, or marginal likelihood
\code{c("descending", "marglik")}
by marginal likelihood.}

\item{digits_estimates}{number of decimals to be displayed for
\code{parameter = "theta"}, \code{parameter = "forest"}, and
\code{type = "individual"} plot.}

\item{show_figures}{which figures should be returned in the case
when multiple plots are generated. Useful when
\code{parameter = "omega", type = "individual"} which generates
a figure for each weights cut-off. Defaults to \code{-1} which
omits the first weight. Set to \code{NULL} to show all figures
or to \code{c(1,3)} to show only the first and third one.}

\item{weights}{whether the weights or weight function should
be returned. Only applicable when \code{parameter = "omega"}.
Defaults to \code{FALSE} - the weight function is plotted.}

\item{...}{additional arguments to be passed to
\link[graphics]{par} if \code{plot_type = "base"}. Especially
useful for \code{parameter == "theta"},
\code{parameter == "forest"} or \code{type = "individual"}
where automatic margins might cut out parts of the labels.}
}
\description{
\code{plot.RoBMA} allows to visualize
different \code{"RoBMA"} object parameters in various
ways. See \code{type} for the different model types.
}
\examples{
\dontrun{
# using the example data from Anderson et al. 2010 and fitting the default model
# (note that the model can take a while to fit)
fit <- RoBMA(r = Anderson2010$r, n = Anderson2010$n, study_names = Anderson2010$labels)

### ggplot2 version of all of the plots can be obtained by adding 'model_type = "ggplot"
# plot function allows to visualize the results of a fitted RoBMA object, for example,
# the model-averaged mean parameter estimate
plot(fit, parameter = "mu")

# or show both the prior and posterior distribution
plot(fit, parameter = "mu", prior = TRUE)

# condtional plots might by obtained by specifying
plot(fit, parameter = "mu", type = "conditional")

# plotting function also allows to visualize the weight function
# (or individual weights by adding 'weights = TRUE')
plot(fit, parameter = "omega")

# or the forest plot (the estimated study effects can be shown by setting 'parameter = "theta"')
plot(fit, parameter = "forest")

# it is also possible to compare the individual model estimates
# and order them by the posterior probability
plot(fit, parameter = "mu", type = "individual", order = "prob")

}
}
\seealso{
\code{\link[=RoBMA]{RoBMA()}}
}
