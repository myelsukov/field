#!/usr/bin/env bash

cmd_field() {
  local opts clip=0
  local field=""

  opts="$($GETOPT -o cn: -l clip,name: -n "$PROGRAM" -- "$@")"
  local err=$?
  eval set -- "$opts"
  while true; do case $1 in
    -c|--clip) clip=1; shift ;;
    -n|--name) field=$2; shift 2;;
    --) shift; break ;;
  esac done

  [[ $err -ne 0 || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--name=field-name,-n field-name] [--clip,-c] pass-name"

  local path="${1%/}"
  local passfile="$PREFIX/$path.gpg"
  check_sneaky_paths "$path"
  [[ ! -f $passfile ]] && die "Passfile not found"

  if [[ -z ${field} ]]; then
    local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | head -n 1)"
  else
    # This will copy only the first line. I don't know yet how to deal with multi-line fields. Below is unsuccessful attempt I keep for reference
    # local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | sed -rn '/^'"${field}"':/I,/^[[:alnum:]]+:/{/^'"${field}"':/I{s/^'"${field}"':[[:space:]]*//Ip;n};/^[[:alnum:]]+:/!{p}}')"
    local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | sed -rn '/^'"${field}"':/I {s/^'"${field}"':[[:space:]]*//Ip;q}')"
  fi
  if [[ $clip -ne 0 ]]; then
    clip "${value}" "${field} from $path"
  else
    echo "${value}"
  fi
}

cmd_field "$@"
exit 0
