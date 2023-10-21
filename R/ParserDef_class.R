setClass("ParserDef",
         representation(
             option_defs = "list"
         ),
         prototype(
             option_defs = list()
         )
         )

setGeneric( 'define_option',
           function (obj, new_setting) { standardGeneric('define_option')}
           )

setGeneric( 'get_defined_option_correspondence',
           function (obj) { standardGeneric('get_defined_option_correspondence')}
           )

setGeneric( 'parse_with_defs',
           function (obj, cmd_args) { standardGeneric('parse_with_defs')}
           )
