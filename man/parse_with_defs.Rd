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
\examples{
\dontshow{
library(defineOptions)
parser_def = new_parser_def() |>
    define_option(
        list(
            def_name = "target_range",
            def_type = "integer",
            long_option = "--target-range",
            input_splitter = ",",
            callback = opt_optional_input_required( input_when_omitted = "70,180" )
        )
    ) |>
    define_option(
        list(
            def_name = "exclude_weekend",
            def_type = "logical",
            long_option = "--exclude-weekend",
            callback = opt_optional_input_disallowed( input_when_specified = "TRUE",
                                                      input_when_omitted = "FALSE" )
        )
    )|>
    define_option(
        list(
            def_name = "output_path",
            def_type = "character",
            long_option = "--output",
            callback = opt_required_input_required()
        )
    )
}
# In practice, command line arguments can be obtained by commandArgs() function
# with trailingOnly option TRUE.
# command_arguments = commandArgs(trailingOnly = TRUE)

example_string = "input1.txt input2.txt --target-range 60,140 --exclude-weekend --output log.data"
command_arguments = strsplit( example_string, " ")[[1]]

parsed_result = parse_with_defs(parser_def, command_arguments) # parser_def is a ParserDef object
}
