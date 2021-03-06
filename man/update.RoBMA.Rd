% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main.R
\name{update.RoBMA}
\alias{update.RoBMA}
\title{Updates a fitted RoBMA object}
\usage{
\method{update}{RoBMA}(
  object,
  refit_failed = TRUE,
  prior_mu = NULL,
  prior_tau = NULL,
  prior_omega = NULL,
  prior_odds = NULL,
  prior_mu_null = NULL,
  prior_tau_null = NULL,
  prior_omega_null = NULL,
  study_names = NULL,
  control = NULL,
  chains = NULL,
  iter = NULL,
  burnin = NULL,
  thin = NULL,
  ...
)
}
\arguments{
\item{object}{a fitted RoBMA object.}

\item{refit_failed}{whether failed models should be refitted. Relevant only
if new priors or \code{prior_odds} are not supplied. Defaults to \code{TRUE}.}

\item{prior_mu}{a prior distribution for the \code{mu} parameter that
will be treated as belonging to the alternative hypothesis.}

\item{prior_tau}{a prior distribution for the \code{tau} parameter that
will be treated as belonging to the alternative hypothesis.}

\item{prior_omega}{a prior weight function for the \code{omega}
parameter that will be treated as belonging to the alternative hypothesis.}

\item{prior_odds}{either a single value specifying prior model odds
of a newly specified model using priors argument, or a vector of the
same length as already fitted models to update their prior odds.}

\item{prior_mu_null}{list of prior distribution for the \code{mu} parameter that
will be treated as belonging to the null hypothesis. Defaults to point distribution
with location at 0 (
\code{prior(distribution = "point", parameters = list(location = 0))}).}

\item{prior_tau_null}{a prior distribution for the \code{tau} parameter that
will be treated as belonging to the null hypothesis.}

\item{prior_omega_null}{a prior weight function for the \code{omega} parameter
that will be treated as belonging to the null hypothesis.}

\item{study_names}{an optional argument with the names of the studies.}

\item{control}{a list of additional arguments for the MCMC algorithm.
Possible options are:
\describe{
\item{autofit}{Whether the models should be refitted until convergence.
Defaults to \code{FALSE}}
\item{max_error}{The target MCMC error for the autofit function. The
argument is passed to \link[coda]{raftery.diag} as 'r'. Defaults to
\code{.01}.}
\item{max_time}{A string specifying the maximum fitting time in case
of autofit. Defaults to \code{Inf}. Can be specified as a number and
a unit (Acceptable units include ’seconds’, ’minutes’, ’hours’, ’days’,
’weeks’, or the first letter(s) of each), i.e. \code{"1hr"}.}
\item{adapt}{A number of iterations used for MCMC adaptation. Defaults
to \code{1000}.}
\item{bridge_max_iter}{Maximum number of iterations for the
\link[bridgesampling]{bridge_sampler} function. Defaults to \code{10000}}
\item{allow_max_error}{Maximum allowed MCMC error for a model to be taken
into consideration. The model will be removed from the ensemble if it fails to
achieve the set MCMC error. Defaults to \code{NULL} - no model will be
removed based on MCMC error.}
\item{allow_max_rhat}{Maximum allowed Rhat for a model to be taken into
consideration. Model will be removed from the ensemble if it fails to
achieve the set Rhat. Defaults to \code{NULL} - no model will be removed
based on Rhat.}
\item{allow_min_ESS}{Minimum allowed ESS for a model to be taken into
consideration. Model will be removed from the ensemble if it fails to
achieve the set ESS. Defaults to \code{NULL} - no model will be removed
based on ESS.}
\item{allow_inc_theta}{Whether the diagnostics for theta should be
included into model removal decision. Defaults to \code{NULL} - only
'mu', 'tau', and 'omega' estimates will be taken into account.}
\item{balance_prob}{Whether the prior probability of the removed model
should be redistributed to other models with the same type if possible
(crossing of effect / heterogeneity / publication bias). Defaults to
\code{TRUE}.}
\item{silent}{Whether all fitting messages should be suppressed. Defaults
to \code{FALSE}. Ideal for getting rid of the "full precision may not have
been achieved in pnt{final}'" warning that cannot be suppressed in any
other way.}
\item{boost}{Whether the likelihood functions implemented using the boost
C++ library should be used as the first option. The higher precision of
boost allows to estimate models in difficult cases. Defaults to \code{FALSE}.
The R distributions are used as default and boost is used only if they fail.
Warning: the estimation using boost takes about twice as long.}
}}

\item{chains}{a number of chains of the MCMC algorithm.}

\item{iter}{a number of sampling iterations of the MCMC algorithm.
Defaults to \code{10000}, with a minimum of \code{4000}.}

\item{burnin}{a number of burnin iterations of the MCMC algorithm.
Defaults to \code{5000}.}

\item{thin}{a thinning of the chains of the MCMC algorithm. Defaults to
\code{1}.}

\item{...}{additional arguments.}
}
\value{
\code{RoBMA} returns an object of \link[base]{class} \code{"RoBMA"}.
}
\description{
\code{update.RoBMA} can be used to
\enumerate{
\item{add an additional model to an existing \code{"RoBMA"} object by
specifying either a null or alternative prior for each parameter
and the prior odds of the model (\code{prior_odds}), see the
\code{vignette("CustomEnsembles")} vignette,}
\item{change the prior odds of fitted models by specifying a vector
\code{prior_odds} of the same length as the fitted models,}
\item{refitting models that failed to converge with updated settings
of control parameters,}
\item{or changing the convergence criteria and recalculating the ensemble
results by specifying new \code{control} argument and setting
\code{refit_failed == FALSE}.}
}
}
\details{
See \code{\link[=RoBMA]{RoBMA()}} for more details.
}
\examples{
\dontrun{
# using the example data from Anderson et al. 2010 and fitting the default model
# (note that the model can take a while to fit)
fit <- RoBMA(r = Anderson2010$r, n = Anderson2010$n, study_names = Anderson2010$labels)

# the update function allows us to change the prior model probability of each model
fit1 <- update(fit, prior_odds = c(10,1,1,1,1,1,1,1,1,1,1,1))

# add an additional model with different priors specification (see '?prior' for more information)
fit2 <- update(fit,
               priors_mu_null = prior("point", parameters = list(location = 0)),
               priors_tau = prior("normal",
                                  parameters = list(mean = 0, sd = 1),
                                  truncation = list(lower = 0, upper = Inf)),
               priors_omega = prior("one-sided",
                                    parameters = list(cuts = c(.05), alpha = c(1, 1))))

# change the model convergence criteria to mark models with ESS lower than 2000 as non-covergent
fit3 <- update(fit, control = list(allow_min_ESS = 2000))

# and refit them failed models with increased number of burnin iterations
fit4 <- update(fit3, burnin = 10000)

}

}
\seealso{
\code{\link[=RoBMA]{RoBMA()}}, \code{\link[=summary.RoBMA]{summary.RoBMA()}}, \code{\link[=prior]{prior()}}, \code{\link[=check_setup]{check_setup()}}
}
