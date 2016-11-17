# Define prompts
autoload -U colors zsh/terminfo
colors

setopt promptsubst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}%s%f:%F{green}%b%f (%u%c) "
zstyle ':vcs_info:*' actionformats "%F{blue}%s%f:%F{cyan}%b%f %F{red}(%a)%f(%u%c) "
zstyle ':vcs_info:*' stagedstr "%F{green}+%f"
zstyle ':vcs_info:*' unstagedstr "%F{red}-%f"

precmd() { vcs_info }

function prompt_pwd {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    _prompt_pwd="$MATCH"
    unset MATCH
  else
    _prompt_pwd="${${${${${pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
}

# Stolen from jnorman
function ruby_version_maybe() {
  if [[ -n "$RUBY_VERSION" ]]; then
    echo " ruby-$RUBY_VERSION"
  fi
}

function prompt_precmd {
  # Load required functions.
  autoload -Uz add-zsh-hook

  # Add hook for calling git-info before each command.
  add-zsh-hook precmd prompt_pwd


  PROMPT='%F{yellow}[%n@%m]%f %F{cyan}${_prompt_pwd}%f ${vcs_info_msg_0_}'
  RPROMPT='$(ruby_version_maybe)'
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_precmd
