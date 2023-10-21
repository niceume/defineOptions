\name{parse_with_defs}
\alias{parse_with_defs}
\alias{parse_with_defs,ParserDef,character-method}
\title{
  Function to parse command line arguments with ParserDef S4 object
}
\description{
  parse_with_defs function parses command line arguments.
}
\usage{
\S4method{parse_with_defs}{ParserDef,character}(obj,cmd_args)
}
\details{
  parse_with_defs is a S4 method of \code{\link{ParserDef}} class. This
  method parses command line options with the definitions of
  ParserDef. It returns a list that holds parsed option values,
  positional arguments and default values for options not specified.
}
\arguments{
  \item{obj}{ParserDef S4 object}
  \item{cmd_args}{character}
}
\value{
  List (S3 parsed_result class)
  \item{values}{ list with values. Each element name is defined by def_name. }
  \item{opt_specified}{ list with boolean values. Each element name
    is defined by def_name. Boolean values that represent whether the
    option are specified in command line arguments or not. 
    FALSE means the value is supplied as a default value through callback mechanism.}
  \item{positional}{ positional arguments. If there are no
    positional arguments, NA is assigned. }
}
\seealso{
  \code{\link{ParserDef-class}}
  \code{\link{defineOptions-package}}
  \code{\link{summary.parsed_result}}
}
\examples{\dontrun{
parsed_result = parse_with_defs(parser_def_obj, commandArgs(trailingOnly
= TRUE))
print(parsed_result)
}}
