# Installation
#
#   ln -s /path/to/pre-commit.sh /path/to/project/.git/hooks/pre-commit
#

# binding.pry check
FILES_PATTERN='\.(rb|erb|haml|coffee)(\..+)?$'
FORBIDDEN='binding.pry'

if git diff --cached --name-only | \
    grep -E $FILES_PATTERN | \
    GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN;
then
    echo 'It seems you left a binding.pry. You should remove it.' && \
    exit 1
fi

# focus check
if git grep --cached -n -E "^\s+(it|describe).*((focus:|:focus\s*=>)\s*true)|(:focus)" -- '*_spec.rb';
then
    echo "It seems you left focused specs. You should remove :focus tags.";
    exit 1
fi

exit 0
