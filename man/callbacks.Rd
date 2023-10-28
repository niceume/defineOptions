\name{Built-in callbacks for option definitions}
\alias{callbacks}
\alias{opt_optional_input_required}
\alias{opt_optional_input_disallowed}
\alias{opt_required_input_required}
\title{
  Built-in callbacks for option definitions
}
\description{
  \code{\link{define_option}} function takes an callback argument. The
following functions return built-in callbacks for the callback  argument.
}
\usage{
opt_optional_input_required( input_when_omitted )
opt_optional_input_disallowed( input_when_specified, input_when_omitted)
opt_required_input_required()
}
\details{
  opt_optional_input_required() function returns a callback that is used
to define that the option is optional but when the option is specified
its input value is required to be specified.
opt_optional_input_disallowed() function returns a callback that is used
to define that the option is optional and input value should not be
specified. This kind of option is called a flag.
opt_required_input_required() function returns a callback that is used
to define that the option is required and its value is also required.
}
\arguments{
  \item{input_when_omitted}{character}
  \item{input_when_specified}{character}
}
\value{
  Function object
}
\seealso{
  \code{\link{define_option}}
  \code{\link{ParserDef-class}}
  \code{\link{defineOptions-package}}
}
\examples{
callback = opt_optional_input_required( input_when_omitted = "70,180" )
callback = opt_optional_input_disallowed( input_when_specified = "TRUE",
                                          input_when_omitted = "FALSE" )
callback = opt_required_input_required()
}
