#
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
alias bonobos-vpn="bash ~/Documents/Bonobos/bonobos-vpn.sh"
alias json="python -mjson.tool"
alias xml="xmllint --format -"

# As of nokogiri 1.6, it will compile its own version of libxml2 and libxslt.
# # While this is convenient, it is slower, and uses about 100MB for each
# # install. For a development machine (many gemsets, bundle install often) this
# # is a better default.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1
