setMethod("define_option",
          signature(obj = "ParserDef", new_setting = "list"),
          function(obj, new_setting){
              new_def = list();

              if(! is.null(new_setting$def_name) ){
                  def_name = new_setting$def_name
              }else{
                  stop("def_name is required to be specified.")
              }

              if(! is.null(new_setting$def_type) ){
                  new_def$def_type = new_setting$def_type
              }else{
                  stop("def_type is required to be specified.")
              }

              if(! is.null(new_setting[["long_option"]])){
                  if(! is.null(new_setting[["short_option"]])){
                      new_def$long_option = new_setting$long_option
                      new_def$short_option = new_setting$short_option
                  }else{
                      new_def$long_option = new_setting$long_option
                      new_def$short_option = NA
                  }
              }else{
                  if(! is.null(new_setting[["short_option"]])){
                      new_def$long_option = NA
                      new_def$short_option = new_setting$short_option
                  }else{
                      stop("long_option or short_option is required to be specified.")
                  }
              }

              new_def$input_splitter = new_setting$input_splitter # splitter is optional

              if(! is.null(new_setting$callback)){
                  new_def$callback = new_setting$callback
              }else{
                      stop("callback is required to be specified.")
              }

              obj@option_defs[[def_name]] = new_def
              return(obj)
          }
          )
