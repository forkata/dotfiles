# Some aliases
alias mkdir="mkdir -p -v"
alias ls="ls --group-directories-first --color=auto -la"
alias xclip="xclip -selection c -i"
alias json="python -mjson.tool"
alias xml="xmllint --format -"
alias ag="rg"
alias fzf="fzy"

# Rails/Ruby aliases
alias be="bundle exec"

# Scrot
alias s='DISPLAY=:0 scrot -s -e "mv \$f ~/Screenshots/"'

# Fzy awesomeness
function f() {
  ag --nocolor -l -g "$1" "${2:-.}" | fzy
}

alias fv='vim $(f)'
alias p='cd ~/Projects/$(ls ~/Projects | fzy)'
alias d='cd ~/Documents/$(ls ~/Documents | fzy)'
alias s='cd ~/src/$(ls ~/src | fzy)'

alias bx9="SOLIDUS_BRANCH=v2.9 bundle exec"
alias bx10="SOLIDUS_BRANCH=v2.10 bundle exec"
alias bx11="SOLIDUS_BRANCH=v2.11 bundle exec"

alias sane="stty sane"
