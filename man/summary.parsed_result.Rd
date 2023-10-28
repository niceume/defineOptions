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
\examples{
\dontshow{
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
summary(parsed_result)
}
