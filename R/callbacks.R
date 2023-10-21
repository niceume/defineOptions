opt_optional_input_required = function( input_when_omitted ){
  fn = function(name, specified, input, options){
                if( specified == FALSE ){ # no option
                    return( input_when_omitted )
                }else if( is.na(input) ){ # option without value
                    stop(paste("Option for", name, "requires value"))
                }else{ # option with value
                    return( input )
                }
  }
  attr(fn, "action") = "store"
  return(fn)
}

# optparse library does not accept optional input.
#opt_optional_input_optional = function( input_when_specified, input_when_omitted ){
#  fn = function(name, specified, input, options){
#                if( specified == FALSE ){ # no option
#                    return( input_when_omitted )
#                }else if( is.na(input) ){ # option wihtout value
#                    return( input_when_specified )
#                }else{ # option with value
#                    return( input )
#                }
#  }
#  return(fn)
#}

opt_optional_input_disallowed = function( input_when_specified, input_when_omitted ){
  fn = function(name, specified, input, options){
                if( specified == FALSE ){ # no option
                    return( input_when_omitted )
                }else if( is.na(input) || input == FALSE ){ # option wihtout value
                    return( input_when_specified )
                }else{ # option with value
                    print(input)
                    stop(paste("Value of option for", name, "is disallowed"))
                }
  }
  attr(fn, "action") = "store_false"
  return(fn)
}

opt_required_input_required = function( ){
  fn = function(name, specified, input, options){
                if( specified == FALSE ){ # no option
                    stop(paste("Option for", name, "is required"))
                }else if( is.null(input) || is.na(input)){ # option wihtout value
                    stop(paste("Option for", name, "requires value"))
                }else{ # option with value
                    return( input )
                }
  }
  attr(fn, "action") = "store"
  return(fn)
}

# optparse library does not accept optional input.
#opt_required_input_optional = function( default_input ){
#  fn = function(name, specified, input, options){
#                if( specified == FALSE ){ # no option
#                    stop(paste("Option for", name, "is required"))
#                }else if( is.na(input) ){ # option wihtout value
#                    return( default_input )
#                }else{ # option with value
#                    return( input )
#                }
#  }
#  return(fn)
#}

# Never happen
#opt_required_input_disallowed = function( default_input ){
#  fn = function(name, specified, input, options){
#                if( specified == FALSE ){ # no option
#                    stop(paste("Option for", name, "is required"))
#                }else if( is.na(input) ){ # option wihtout value
#                    return( default_input )
#                }else{ # option with value
#                    stop(paste("Value of option for", name, "is disallowed"))
#                }
#  }
#  return(fn)
#}

