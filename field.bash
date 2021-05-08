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
    local value="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | awk -v field="${field}:" 'BEGIN {p=0; regex="^"field"[ \t]*"} $0 !~ regex && /.+:/ {p=0} {if (p == 1) {print}} $0 ~ regex {p=1; sub(regex, "");  print}')"
  fi
  if [[ $clip -ne 0 ]]; then
    clip "${value}" "${field} from $path"
  else
    echo "${value}"
  fi
}

cmd_field "$@"
exit 0
