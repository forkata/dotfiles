# Some aliases
alias mkdir="mkdir -p -v"
alias ls="gls --group-directories-first --color=auto -la"
alias xclip="xclip -selection c -i"
alias json="python -mjson.tool"
alias xml="xmllint --format -"
alias ag="rg"

# Rails/Ruby aliases
alias be="bundle exec"

# Scrot
alias s='DISPLAY=:0 scrot -s -e "mv \$f ~/Screenshots/"'

# Use hub if it's installed
if command -v hub &> /dev/null; then
    eval "$(hub alias -s)"
fi

# Fzy awesomeness
function f() {
  ag --nocolor -l -g "$1" "${2:-.}" | fzy
}

alias fv='vim $(f)'
alias p='cd ~/Projects/$(ls ~/Projects | fzy)'
alias d='cd ~/Documents/$(ls ~/Documents | fzy)'
