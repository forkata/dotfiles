#
# Git aliases
#

# What i committed today
alias glT='git log --since="6am" --format="%s%n%b" --author="$(git config --global user.name)"| grep "^[^(Change-id)]"'

alias gb='git branch'
alias gba='git branch -a'

alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'

alias gd='git diff'
alias gdc='git diff --cached'

alias gl='git pull'
alias gp='git push'

alias ga='git add'
alias gaa='git add . && echo "git added ."'

alias gst='git status'
alias gsH='git show'

alias vgws='git status --porcelain --ignore-submodules | cut -f 3 -d" " | xargs vim -pO ${1}'

alias glf='git log --pretty=oneline -S'

alias grubo='git status --porcelain | grep -v "^[D|R]" | cut -c4- | xargs rubocop'

alias gco='git checkout `git branch | fzy`'
alias gcb='git checkout -b'
