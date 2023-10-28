\name{define_option}
\alias{define_option}
\alias{define_option,ParserDef,list-method}
\title{
  Function to define an option for argument parsing
}
\description{
  define_option function adds a new definition for argument parsing.
}
\usage{
\S4method{define_option}{ParserDef,list}(obj,new_setting)
}
\details{
  define_option is a S4 method of \code{\link{ParserDef}} class. This
  method adds a definition of argument parsing to a ParserDef
  object. new_setting argument requires a list that consists of
  def_name, def_type, long_option, short_option, input_splitter and callback.
  def_name, def_type, long_option or short_option and callback are
  required elements. def_name is an identifier of this definition and also
  works as a name of an element of a list as the final parsing
  result. def_type is a type to which each input value is cast
  into. long_option or short_option defines a part of command line
  options strting from dash such as "--output" and "-o". input_splitter
  splits input value with the characters specified. Callback is
  important and defines how the option should be
  specified. \code{\link{callbacks}} document describes its detail.
}
\arguments{
  \item{obj}{ParserDef S4 object}
  \item{new_setting}{list}
}
\value{
  ParserDef object
}
\seealso{
  \code{\link{ParserDef-class}}
  \code{\link{defineOptions-package}}
}
\examples{
parser_def = new_parser_def() |>
    define_option(
        list(
            def_name = "target_range",
            def_type = "integer",
            long_option = "--target-range",
            short_option = "-t",
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
