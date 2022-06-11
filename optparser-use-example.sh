#!/usr/bin/env bash

# define variables with default values.  this must be done before the options
# array is declared.  might as well define other variables here as well
output_default="/var/usr/share/local/test.txt"
error_code=0

# create the options array, one option and its info per line.  see the README
# file for the format of each option line
declare -a getopt_options=(
  "d|debug debug debug the program."
  "f|force force force it to work."
  "o:|output:FILE@${output_default} output output is put in the specified FILE, which can be a full pathname."
  "v|verbose verbose say lots of things."
)

# check to make sure at least one option was supplied.  if not, print an error
# message, set an error flag, and then pass the '-h' option to 'optparser' so
# the help message is printed as well
if [[ "${#}" == 0 ]]; then printf '\n%s\n' "Error: must supply an option!!!"; error_code=1; set -- "-h"; fi

# call 'optparer', passing the option array and the options passed to this
# program.  the output from 'optparser' is the valid option names and their
# values, and is saved in a variable for further processing
valid_options=`optparser <( (( ${#getopt_options[@]} )) && printf '%s\0' "${getopt_options[@]}") "${@}"`

# save the return code from 'optparser'
return_code="${?}"

# if the error flag is set, indicating that no options were supplied to this
# program, exit with code 1
if [[ "${error_code}" == 1 ]]; then exit 1; fi

# 'optparser' exits with code 255 if the help message was requested...since
#  that's a "success" condition for this program, exit with code 0
if [[ "${return_code}" == 255 ]]; then exit; fi

# 'optparser' exits with a code between 1 and 254 inclusive if there was an
#  error...since that's also a error condition for this program, exit with the
#  code from 'optparser'
if [[ "${return_code}" -ne 0 ]]; then exit "${return_code}"; fi

# the option name/value assignments returned by 'optparser' are now executed
# with 'eval' so that they can be used for further processing
eval "${valid_options}"

# read the option name/value pairs returned from 'optparser' into an
# array...this results in one pair per element of the array.  this is done so
# that, while the 'case' statement following has entries for all the options
# available in this program, only the ones actually supplied on the command
# line are processed
read -ra set_options -d '' <<< "${valid_options}"

# loop through each element of the array
for option_name in "${set_options[@]}"; do

  # strip off the value portion, leaving only the option name
  option_name="${option_name/=*/}"

  # the 'case' statement is built from the valid options in the options array.
  # while building the statement by hand is fine for a program such as this
  # with only a few options, a more automated way would be better for a program
  # with lots of options.  I'm working on it :-)  note that there is no
  # 'default' option in the 'case' statement...one isn't needed because it isn't
  # possible for an "unknown" option to make it this far

  # now figure out which option supplied to this program is being checked and
  # do something with it
  case "${option_name}" in
      debug) printf '%s\n' "debug is set, so do something with it here"
             ;;
      force) printf '%s\n' "force is set, so do something with it here"
             ;;
     output) printf '%s\n' "output is ${output}, so do something with it here"
             ;;
    verbose) printf '%s\n' "verbose is set, so do something with it here"
             ;;
  esac
done

# check to see if there were any non-option arguments supplied to this program.
# if there were, do something with them here
if [[ -n "${remaining_args}" ]]; then
  printf '%s\n' "There are additional, non-option arguments, so do something with them here"
  printf '%s\n' "remaining arguments together are: >${remaining_args}<" "remaining arguments separate are:"
  read -ra non_options -d '' <<< "${remaining_args}"
  for a in "${non_options[@]}"; do printf '%s\n' "argument is >${a}<"; done
fi
