categorize_arguments = function(input_characters){
    if(length(input_characters) == 0 || (length(input_characters) == 1 && input_characters == "") ){
    # When no argumnets, return value is list(options = list(), positional = NA)
        return(
            list(options = list(), positional = NA)
        )
    }

    option_name_bools = grepl("^-", input_characters)
    input_length = length(input_characters)

#    print(option_name_bools)
    option_name_positions = which(option_name_bools == TRUE)
#    print(option_name_positions)

    cumsum_option_names = cumsum(option_name_bools)
#    print(cumsum_option_names)

    cumsum_at_option_name_pos = cumsum_option_names[option_name_positions]
    cumsum_at_possible_value_pos = cumsum_option_names[option_name_positions + 1]

    if(any(is.na(cumsum_at_possible_value_pos))){ # when the last argument is option name, the last value can be NA.
        cumsum_at_option_name_pos = cumsum_at_option_name_pos[!is.na(cumsum_at_possible_value_pos)]
        cumsum_at_possible_value_pos = cumsum_at_possible_value_pos[!is.na(cumsum_at_possible_value_pos)]
    }
#    print(cumsum_at_option_name_pos)
#    print(cumsum_at_possible_value_pos)

    name_pos_option_with_value = option_name_positions[ cumsum_at_option_name_pos == cumsum_at_possible_value_pos ]
    value_pos_option_with_value = name_pos_option_with_value + 1
    name_pos_option_only_name = option_name_positions[ cumsum_at_option_name_pos != cumsum_at_possible_value_pos ]
    pos_positional_argument = setdiff(seq(input_length) , c(name_pos_option_with_value, value_pos_option_with_value, name_pos_option_only_name ))

#    print(name_pos_option_with_value)
#    print(value_pos_option_with_value)
#    print(name_pos_option_only_name)
#    print(pos_positional_argument)

    options = list()
    if(length(name_pos_option_with_value) >= 1){
        for( i in seq(length(name_pos_option_with_value))){
            pos_opt_name = name_pos_option_with_value[i]
            pos_opt_value = value_pos_option_with_value[i]
            options[input_characters[pos_opt_name]] = input_characters[pos_opt_value]
        }
    }
    if(length(name_pos_option_only_name) >= 1){
        for( i in seq(length(name_pos_option_only_name))){
            pos_opt_name = name_pos_option_only_name[i]
            options[input_characters[pos_opt_name]] = NA
        }
    }

    if(length(pos_positional_argument) >= 1){
        positional = input_characters[pos_positional_argument]
    }else{
        positional = NA
    }

    return(list(options = options, positional = positional))
    # When only options, return value is list(options = list(...), positoinal = NA)
    # When only positional, return value is list(options = list(), positional = c(...))
}

setMethod( "get_defined_option_correspondence",
          signature(obj = "ParserDef"),
          function(obj){
              option_defs = obj@option_defs
              df = data.frame()
              for( name in names(option_defs)){
                  long_option = option_defs[[name]]$long_option
                  short_option = option_defs[[name]]$short_option
                  df = rbind(df, data.frame(
                                     name = name,
                                     long_option = long_option,
                                     short_option = short_option
                                 ))
              }
              correspondence_df = rbind(
                  data.frame( name = df$name,
                             option = df$long_option),
                  data.frame( name = df$name,
                             option = df$short_option)
              )
              correspondence_df = correspondence_df[!is.na(correspondence_df$option), ]
              return(correspondence_df)
          }
          )


setMethod("parse_with_defs",
          signature(obj = "ParserDef", cmd_args = "character"),
          function(obj, cmd_args){
              if(length(cmd_args) >= 1){
                  cmd_args = unlist(strsplit(cmd_args, "="))
              }
              argument_list = categorize_arguments(cmd_args)
              defined_option_correspondence = get_defined_option_correspondence(obj)
              defined_options = defined_option_correspondence$option
              if( any( (names(argument_list$options) %in% defined_options) == FALSE )){
                  cat( "undefined option specified: " )
                  cat( names(argument_list$options)[(names(argument_list$options) %in% defined_options) == FALSE])
                  cat( "\n" )
                  stop()
              }
              
              opts = list()
              for(option_name in names(argument_list$options)){
                  idx = grep(option_name, defined_option_correspondence$option)[1]
                  dest_name = defined_option_correspondence$name[idx]
                  opts[[dest_name]] = argument_list$options[[option_name]]
              }

              positional = argument_list$positional

              parsed_result = list()
              value_list = list()
              opt_specified_list = list()
              for( def_name in names(obj@option_defs)){
                  opt_input = opts[[def_name]]
                  opt_specified = TRUE
                  if(is.null(opt_input)){
                      opt_input = NA
                      opt_specified = FALSE
                  }
                  long_option = obj@option_defs[[def_name]]$long_option
                  short_option = obj@option_defs[[def_name]]$short_option
                  opt_options = c(ifelse(is.na(long_option), "", long_option),
                                  ifelse(is.na(short_option), "", short_option))
                  opt_callback = obj@option_defs[[def_name]]$callback 
                  if(! is.null(opt_callback)){
                      input_value = opt_callback(def_name, opt_specified, opt_input, opt_options)
                  }else{
                      input_value = opt_input
                  }
                  input_splitter = obj@option_defs[[def_name]]$input_splitter
                  if(! is.null(input_splitter )){
                      value = strsplit(input_value, input_splitter)[[1]]
                  }else{
                      value = input_value
                  }

                  def_type = obj@option_defs[[def_name]]$def_type
                  if( typeof(value) != def_type){
                      value = methods::as(value, def_type)
                  }

                  value_list[[def_name]] = value
                  opt_specified_list[[def_name]] = opt_specified
              }
              parsed_result$values = value_list
              parsed_result$opt_specified = opt_specified_list
              parsed_result$positional = positional
              return( structure(parsed_result, class="parsed_result"))
          }
          )

summary.parsed_result = function( object, ... ){
    parsed_result = object
    df = data.frame()
    for( name in names(parsed_result$values) ){
        df = rbind(df, data.frame(
                           name = name,
                           opt_specified = parsed_result$opt_specified[[name]],
                           value = parsed_result$values[[name]]
                  ))
    }
    positional = parsed_result$positional

    result = list(
        "message" = "summary of parsed_result object",
        "assigned values" = df,
        "positional arguments" = positional
    )
    return(result)
}
