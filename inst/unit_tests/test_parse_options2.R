test_parse_options2 = function(){
    parser_def = defineOptions::new_parser_def() |>
        defineOptions::define_option(
            list(
                def_name = "target_range",
                def_type = "integer",
                long_option = "--target-range",
                short_option = "-t",
                input_splitter = ",",
                callback = defineOptions::opt_optional_input_required( input_when_omitted = "70,180" )
            )
        ) |>
        defineOptions::define_option(
            list(
                def_name = "exclude_weekend",
                def_type = "logical",
                long_option = "--exclude-weekend",
                callback = defineOptions::opt_optional_input_disallowed( input_when_specified = "TRUE",
                                                         input_when_omitted = "FALSE" )
            )
        )|>
        defineOptions::define_option(
            list(
                def_name = "output",
                def_type = "character",
                long_option = "--output",
                callback = defineOptions::opt_required_input_required()
            )
        )

    example_string1 = "input1.txt input2.txt --target-range 60,140 --exclude-weekend --output log.data"
    example_string2 = "input1.txt input2.txt --target-range 60,140 --output log.data --exclude-weekend"
    example_string3 = "input1.txt input2.txt --target-range 60,140 --exclude-weekend --output log.data h1 h2"
    
    command_arguments = strsplit( example_string1, " ")[[1]]
    parsed_args = defineOptions::parse_with_defs( parser_def,
                                                 command_arguments)
    RUnit::checkEqualsNumeric( parsed_args$values[["target_range"]], c(60,140))
    RUnit::checkEquals( parsed_args$values[["exclude_weekend"]], TRUE )
    RUnit::checkEquals( parsed_args$values[["output"]], "log.data" )
    RUnit::checkEquals( parsed_args$positional, c("input1.txt", "input2.txt"))

    command_arguments = strsplit( example_string2, " ")[[1]]
    parsed_args = defineOptions::parse_with_defs( parser_def,
                                                 command_arguments)
    RUnit::checkEqualsNumeric( parsed_args$values[["target_range"]], c(60,140))
    RUnit::checkEquals( parsed_args$values[["exclude_weekend"]], TRUE )
    RUnit::checkEquals( parsed_args$values[["output"]], "log.data" )
    RUnit::checkEquals( parsed_args$positional, c("input1.txt", "input2.txt"))

    command_arguments = strsplit( example_string3, " ")[[1]]
    parsed_args = defineOptions::parse_with_defs( parser_def,
                                                 command_arguments)
    RUnit::checkEqualsNumeric( parsed_args$values[["target_range"]], c(60,140))
    RUnit::checkEquals( parsed_args$values[["exclude_weekend"]], TRUE )
    RUnit::checkEquals( parsed_args$values[["output"]], "log.data" )
    RUnit::checkEquals( parsed_args$positional, c("input1.txt", "input2.txt", "h1", "h2"))
}
