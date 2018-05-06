#!/usr/bin/env bash

cmd_field() {
  local opts clip=0
  local field=""

  if [[ $# -gt 1 ]]; then  
    if [[ ! $1 =~ - ]]; then
       field=$1
       shift
    fi
  fi
  
  opts="$($GETOPT -o c -l clip -n "$PROGRAM" -- "$@")"
  local err=$?
  eval set -- "$opts"
  while true; do case $1 in
    -c|--clip) clip=1; shift ;;
    --) shift; break ;;
  esac done

  [[ $err -ne 0 || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [field-name] [--clip,-c] pass-name"

  local path="${1%/}"
  local passfile="$PREFIX/$path.gpg"
  check_sneaky_paths "$path"
  [[ ! -f $passfile ]] && die "Passfile not found"

  contents=$($GPG -d "${GPG_OPTS[@]}" "$passfile")
  if [[ -z ${field} ]]; then
    local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | head -n 1)"
  else
    local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | sed -n '/^'"${field}"':/I,/^[[:alnum:]]*:/{/^'"${field}"':/I{s/^'"${field}"':[[:space:]]//Ip;n};/^[[:alnum:]]*:/!{p}}')"
  fi
  if [[ $clip -ne 0 ]]; then
    clip "${value}" "${field} from $path"
  else
    echo "${value}"
  fi
}

cmd_field "$@"
exit 0
