## lolcommits hook (begin) ###
export LANG="en_CA.UTF-8"
export PATH="/home/chris/.rubies/ruby-2.2.2/bin:/usr/bin:$PATH"
if [ ! -d "$GIT_DIR/rebase-merge" ]; then
    lolcommits --capture --gif --animate=2 --fork --stealth
fi
##  lolcommits hook (end)  ###

exit 0
