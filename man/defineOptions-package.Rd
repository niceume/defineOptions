%File defineOptions-package.Rd
\name{defineOptions-package}
\alias{defineOptions-package}
\alias{defineOptions}
\docType{package}
\title{
\packageTitle{defineOptions}
}
\description{
\packageDescription{defineOptions}
}
\details{
Definitions are consturcted by calling \code{\link{define_option}} method for \code{\link{ParserDef}} object, which is
instantiated by \code{\link{new_parser_def}} function. The second argument of \code{\link{define_option}} takes a list
that has defition about how to parse and store its option value. The definition also holds information about how to behave
when the option is not specified. Finally, \code{\link{parse_with_defs}} function takes command line arguments and \code{\link{ParserDef}} object
and returns parsing result.
}
\author{
\packageAuthor{defineOptions}
Maintainer: \packageMaintainer{defineOptions}
}
\keyword{ package }
\seealso{
  \code{\link{ParserDef}}
  \code{\link{new_parser_def}}
  \code{\link{define_option}}
  \code{\link{parse_with_defs}}
  \code{\link{callbacks}}
}
\examples{
library(defineOptions)
parser_def = new_parser_def() |>
    define_option(
        list(
            def_name = "target_range",
            def_type = "integer",
            long_option = "--target-range",
            short_option = "-r",
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

# In practice, command line arguments can be obtained by commandArgs() function
# with trailingOnly option TRUE.
# command_arguments = commandArgs(trailingOnly = TRUE)

example_string = "input1.txt input2.txt --target-range 60,140 --exclude-weekend --output log.data"
command_arguments = strsplit( example_string, " ")[[1]]
parsed_args = parse_with_defs( parser_def, command_arguments)
print(parsed_args)
}

