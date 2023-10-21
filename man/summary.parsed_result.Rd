\name{summary.parsed_result}
\alias{summary.parsed_result}
\title{
  Summarize parsed_result S3 object
}
\description{
  summary function for parsed_result S3 object.
}
\usage{
\method{summary}{parsed_result}(object,...)
}
\details{
  summary function for parsed_result S3 object. This enables users to see how values are assigned.
}
\arguments{
  \item{object}{S3 parsed_result class}
  \item{...}{Further arguments passed to or from other methods.}
}
\seealso{
  \code{\link{parse_with_defs}}
}
\examples{\dontrun{
parsed_result = parse_with_defs(parser_def_obj, commandArgs(trailingOnly
= TRUE))
summary(parsed_result)
}}
