# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias xclip="xclip -selection c -i"
alias be="bundle exec"
alias vssh="vagrant ssh"
alias json="python -mjson.tool"
alias xml="xmllint --format -"
alias chrome="google-chrome-unstable"

# Git
# what i committed today
alias glT='git log --since="6am" --format="%s%n%b" --author="$(git config --global user.name)"| grep "^[^(Change-id)]"'

alias gb='git branch'
alias gba='git branch -a'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -a'

alias gd='git diff'
alias gdc='git diff --cached'

alias gl='git pull'
alias gp='git push'

alias ga='git add'
alias gaa='git add . && echo "git added ."'
# alias gpa='echo "running: git push --all" && git push --all'

alias gst='git status'
alias gsH='git show'
alias vgws='git status --porcelain --ignore-submodules | cut -f 3 -d' ' | xargs vim -pO ${1}'

alias glf='git log --pretty=oneline -S'

alias update_ubuntu="sudo apt-get update && sudo apt-get upgrade"

# Zsh command history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# Fzy Awesomeness
#unsetopt flowcontrol
#function insert-fzy-path-in-command-line() {
#  local selected_path
#  echo
#  selected_path=$(ag . -l -g '' | fzy) || return
#  eval 'LBUFFER="$LBUFFER$selected_path"'
#  zle reset-prompt
#}
#function insert-fzy-dir-in-command-line() {
#  local selected_path
#  echo
#  selected_path=$(find -type d| fzy) || return
#  eval 'LBUFFER="$LBUFFER$selected_path"'
#  zle reset-prompt
#}
#zle -N insert-fzy-path-in-command-line
#zle -N insert-fzy-dir-in-command-line
#bindkey "^f" insert-fzy-path-in-command-line
#bindkey "^i" insert-fzy-dir-in-command-line

# Key bindings
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

export KEYTIMEOUT=1

# As of nokogiri 1.6, it will compile its own version of libxml2 and libxslt.
# # While this is convenient, it is slower, and uses about 100MB for each
# # install. For a development machine (many gemsets, bundle install often) this
# # is a better default.
# export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# source .zshrc_local for any workstation specific settings
test -r ~/.zshrc.local && source ~/.zshrc.local
