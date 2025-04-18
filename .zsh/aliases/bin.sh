# Some aliases
alias mkdir="mkdir -p -v"

if [ Darwin = `uname` ]; then
  alias ls="gls --group-directories-first --color=auto -la"
else
  alias ls="ls --group-directories-first --color=auto -la"
fi

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

if [ Darwin = `uname` ]; then
  alias p='cd ~/Projects/"$(gls ~/Projects | fzy)"'
  alias d='cd ~/Documents/"$(gls ~/Documents | fzy)"'
  alias s='cd ~/src/"$(gls ~/src | fzy)"'
else
  alias p='cd ~/Projects/"$(ls ~/Projects | fzy)"'
  alias d='cd ~/Documents/"$(ls ~/Documents | fzy)"'
  alias s='cd ~/src/"$(ls ~/src | fzy)"'
fi

alias sane="stty sane"
