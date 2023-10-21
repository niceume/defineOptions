\name{ParserDef-class}
\alias{ParserDef-class}
\alias{ParserDef}
\title{
ParserDef S4 class
}
\description{
ParserDef object stores definitions of command line arguments and their
parsing.
}
\details{
  Package users can create an object of ParserDef class using
  \code{\link{new_parser_def}} function. \code{\link{define_option}}
  function adds a new definition for command line
  parsing. \code{\link{parse_with_defs}} function parses command line
  arguments based on the definitions of ParserDef object. Each
  definition searches whether their options are specified or not.
  Each definition invokes their callbacks and processes specified input,
  or assign default input values if they are not specified.
  After callback execution, return value of characters are splitted by
  input_splitter if input_splitter is specified. Then, the value is cast
  into def_type. The result values are stored as an element of a list,
  and each element name is defined by def_name. Remaining arguments are
  treated as positional arguments. 
}
\seealso{
  \code{\link{new_parser_def}}
  \code{\link{define_option}}
  \code{\link{parse_with_defs}}
  \code{\link{defineOptions-package}}
}
