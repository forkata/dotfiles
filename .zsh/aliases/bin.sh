#
# Some aliases
#
alias ls="ls --group-directories-first --color=auto"
alias xclip="xclip -selection c -i"
alias vssh="vagrant ssh"
alias json="python -mjson.tool"
alias xml="xmllint --format -"
alias chrome="google-chrome-unstable"
alias update_ubuntu="sudo apt-get update && sudo apt-get upgrade"

# Rails/Ruby aliases
alias be="bundle exec"
alias pspec='RAILS_ENV=test be rake parallel:spec'

# Scrot
alias s='scrot -s -e "mv \$f ~/Screenshots/"'

# Use hub
eval "$(hub alias -s)"

# Fzy awesomeness
function f() {
  ag --nocolor -l -g "$1" "${2:-.}" | fzy
}

alias fv='vim $(f)'
alias p='cd ~/Projects/$(ls ~/Projects | fzy)'
