fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit promptinit
compinit
promptinit

# Teamocil zsh completions.
compctl -g '~/.teamocil/*(:t:r)' teamocil

setopt autocd

# Dir colors.
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

export KEYTIMEOUT=1

export REPORTTIME=10

# For a development machine this is a better default.
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# Source stuff.
source ~/.zsh/aliases/git.sh
source ~/.zsh/aliases/bin.sh
source ~/.zsh/aliases/arch.sh
source ~/.zsh/aliases/ubuntu.sh
source ~/.zsh/bindings.sh
source ~/.zsh/prompt.sh
source ~/.zsh/history.sh

# Chruby
if [ Darwin = `uname` ]; then
  source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
  source /opt/homebrew/opt/chruby/share/chruby/auto.sh
else
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# Source .zshrc_local for any workstation specific settings.
test -r ~/.zshrc.local && source ~/.zshrc.local
