# Inspect directory storage in current directory
alias inspect="du -d 1 -h | sort -h"

# Generate random values of different types
alias randhex='python3 ~/dev/dotfiles-setup/scripts/random_values.py hex'
alias randstr='python3 ~/dev/dotfiles-setup/scripts/random_values.py str'
alias randint='python3 ~/dev/dotfiles-setup/scripts/random_values.py int'

# Clean up commands
alias flushpoetry="poetry cache list | awk '{print \$1}' | xargs -I {} poetry cache clear --all {}"
alias flushpip="pip cache purge"
alias flushpyc="find . -type d -name '__pycache__' -exec rm -r {} + && find . -type f -name '*.pyc' -delete"
