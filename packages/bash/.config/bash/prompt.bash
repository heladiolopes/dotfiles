WORKSTATION_PROMPT='>>'

PROMPT_GREEN='\[\033[1;32m\]'
PROMPT_YELLOW='\[\033[0;33m\]'
PROMPT_BLUE='\[\033[1;34m\]'
PROMPT_CYAN='\[\033[1;36m\]'
PROMPT_RESET='\[\033[0m\]'

workstation_prompt_cwd() {
  if [[ $PWD == "$HOME" || $PWD == "$HOME/"* ]]; then
    printf '~%s' "${PWD#"$HOME"}"
  else
    printf '%s' "$PWD"
  fi
}

workstation_prompt_python() {
  local name
  if [ -n "${CONDA_DEFAULT_ENV:-}" ]; then
    printf '%s(%s)%s' "$PROMPT_CYAN" "$CONDA_DEFAULT_ENV" "$PROMPT_RESET"
  elif [ -n "${VIRTUAL_ENV:-}" ]; then
    name=${VIRTUAL_ENV##*/}
    printf '%s(%s)%s' "$PROMPT_CYAN" "$name" "$PROMPT_RESET"
  fi
}

workstation_prompt_git() {
  local out line branch='' ahead=0 behind=0 staged=0 modified=0 untracked=0 status=''
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  if command -v timeout >/dev/null 2>&1; then
    out=$(timeout 0.15 git status --porcelain=1 -b 2>/dev/null) || return
  else
    out=$(git status --porcelain=1 -b 2>/dev/null) || return
  fi
  while IFS= read -r line; do
    case $line in
      '## '*)
        branch=${line#\#\# }
        branch=${branch%%...*}
        [[ $line =~ ahead[[:space:]]+([0-9]+) ]] && ahead=${BASH_REMATCH[1]}
        [[ $line =~ behind[[:space:]]+([0-9]+) ]] && behind=${BASH_REMATCH[1]}
        ;;
      '?? '*) ((untracked += 1)) ;;
      *)
        [ "${line:0:1}" = ' ' ] || ((staged += 1))
        [ "${line:1:1}" = ' ' ] || ((modified += 1))
        ;;
    esac
  done <<<"$out"
  ((ahead == 0)) || status+="⇡$ahead"
  ((behind == 0)) || status+="⇣$behind"
  ((staged == 0)) || status+=" +$staged"
  ((modified == 0)) || status+=" !$modified"
  ((untracked == 0)) || status+=" ?$untracked"
  printf ' %s(%s%s)%s' "$PROMPT_YELLOW" "$branch" "${status:+ $status}" "$PROMPT_RESET"
}

workstation_prompt_terraform() {
  local workspace
  command -v terraform >/dev/null 2>&1 && [ -d .terraform ] || return
  workspace=$(terraform workspace show 2>/dev/null) || return
  [ -z "$workspace" ] || printf '%s[tf:%s]%s' "$PROMPT_YELLOW" "$workspace" "$PROMPT_RESET"
}

workstation_prompt_fill() {
  local content=$1 clean width dots
  clean=$(printf '%s' "$content" | sed 's/\\\[//g; s/\\\]//g; s/\\033\[[0-9;]*m//g')
  width=${COLUMNS:-}
  if [ -z "$width" ] && command -v tput >/dev/null 2>&1; then
    width=$(tput cols 2>/dev/null)
  fi
  [[ $width =~ ^[0-9]+$ ]] || width=80
  dots=$((width - ${#clean}))
  ((dots <= 0)) || printf '%*s' "$dots" '' | tr ' ' '-'
}

workstation_prompt_command() {
  local context workdir branch environment terraform left right fill
  context="$PROMPT_GREEN\u@\h$PROMPT_RESET"
  workdir="$PROMPT_BLUE$(workstation_prompt_cwd)$PROMPT_RESET"
  branch=$(workstation_prompt_git)
  environment=$(workstation_prompt_python)
  terraform=$(workstation_prompt_terraform)
  left="${context}:${workdir}${branch} "
  right=" ${environment}${terraform}"
  fill="$PROMPT_BLUE$(workstation_prompt_fill "$left$right")$PROMPT_RESET"
  PS1="$left$fill$right\n$PROMPT_BLUE$WORKSTATION_PROMPT$PROMPT_RESET "
}

PROMPT_COMMAND=workstation_prompt_command
