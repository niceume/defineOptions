# R package defineOptions

## About defineOptions

This package enables users to define how to parse command line arguments and how to assign them to a list.
Values to be assigned when the options is not specified can also be defined.
Names to store values, their types, their long or short option names and callbacks for each definition are defined.
Arguments other than options are stored as positional arguments.


## Example

* analyze_log.R

```r
library(defineOptions)
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
    ) |>
    define_option(
        list(
            def_name = "exclude_holiday",
            def_type = "logical",
            long_option = "--exclude-holiday",
            callback = opt_optional_input_disallowed( input_when_specified = "TRUE",
                                                      input_when_omitted = "FALSE" )
        )
    ) |>
    define_option(
        list(
            def_name = "output_path",
            def_type = "character",
            long_option = "--output",
            callback = opt_required_input_required()
        )
    )


command_arguments = commandArgs(trailingOnly = TRUE)
parsed_args = parse_with_defs( parser_def, command_arguments)
print(parsed_args)
print(summary(parsed_args))
```

* Run the example with command line arguments

```
Rscript analyze_log.R input1.txt input2.txt --target-range 60,140 --exclude-weekend --output log.data
```


* Output

```
$values
$values$target_range
[1]  60 140

$values$exclude_weekend
[1] TRUE

$values$exclude_holiday
[1] FALSE

$values$output_path
[1] "log.data"


$opt_specified
$opt_specified$target_range
[1] TRUE

$opt_specified$exclude_weekend
[1] TRUE

$opt_specified$exclude_holiday
[1] FALSE

$opt_specified$output_path
[1] TRUE


$positional
[1] "input1.txt" "input2.txt"

attr(,"class")
[1] "parsed_result"
```

summary() function makes it easy to browse how values are assigned.

```
$message
[1] "summary of parsed_result object"

$`assigned values`
             name opt_specified    value
1    target_range          TRUE       60
2    target_range          TRUE      140
3 exclude_weekend          TRUE        1
4 exclude_holiday         FALSE        0
5     output_path          TRUE log.data

$`positional arguments`
[1] "input1.txt" "input2.txt"
```


## How arguments are defined

Definitions are consturcted by calling define_option() method for ParserDef object, which is
instantiated by new_parser_def() function. The second argument of define_option() takes a list
that consists of def_name, def_type, long_option, short_option, input_splitter and callback.

| Setting name        | Description                                             |
| ------------------- | ------------------------------------------------------- |
| def_name            | An identifier of this definition                        |
|                     | Element name of the final parsing result                |
| def_type            | Type into which each input is cast                      |
| long_option         | (e.g.) --output                                         |
| short_option        | (e.g.) -o  # Exactly one letter is allowed.             |
| input_splitter      | Splitter                                                |
| callback            | How to process input or define default input            |

* def_name and def_type are required.
* long_option or short_option is required.
* input_splitter is optional.
* callback is required.

## How command line arguments are parsed

1. Start parsing command line argumetns with definitions. parse_with_defs() method.
2. If an option takes a value, its value is dealt as its input as characters.
3. Callbacks of all the definitions are executed.
    + Callback function takes four arguments, which take the following values.
        + name: def_name value is supplied
        + specified: TRUE if option is specified in command line arguments. Otherwise FALSE.
        + input: input value from command line arguments. If not provided, NA is passed here.
        + optoins: concatenation of long_option and short_option
    + Each Callback returns a new input as a chracter object or raise an error when its input is inappropriate.
4. Inputs can be splitted with a letter specified by input_splitter.
5. Inputs are cast into the type specified as def_type.
    + as() function is used for this process.
6. The results are returned in a list (S3 parsed_result class).
    + values: A list of vlues, and each element name is specified by def_name.
    + opt_specified: A list of boolean vlues of whether its options were specified in command line arguments or not, and each element name is specified by def_name.
    + positoinal: a vector of positional arguments. If there are no positoinal arguments, NA is assigned.

## Built-in callbacks

The following functions return callbacks that can be assined to callback in define_option method. 
Each callback defines how to manage inputs, supply inputs and also raise an error when the input
is inappropriately specified or is inappropriately unspecified,

| Functions returning callbacks  | Option     | Value       | Option Example                  |
| ------------------------------ | ---------- | ----------- | ------------------------------- |
| opt_optional_input_required    | Optional   | Required    | --target-range 70,180 # or null |
| opt_optional_input_disallowed  | Optional   | No          | --wihtout-weekend # or null     |
| opt_required_input_required    | Required   | Required    | --output log.data # never null  |

Each function takes the following paramters when definition.

| Functions returning callbacks  | Parameters                               |
| ------------------------------ | ---------------------------------------- |
| opt_optional_input_required    | input_when_omitted                       |
| opt_optional_input_disallowed  | input_when_specified, input_when_omitted |
| opt_required_input_required    | NA                                       |

opt_optional_input_required function requires what input should be supplied when this option is omitted.

opt_optional_input_disallowed function requires what inputs should be supplied when then option is specified or is omitted. The option defined by this callback is called a flag.

opt_required_input_required function does not require any parameters, because it always require values to be supplied as command line options. 


## Website

https://github.com/niceume/defineOptions


## Contact

Your feedback is welcome.

Maintainer: Toshi Umehara toshi@niceume.com

