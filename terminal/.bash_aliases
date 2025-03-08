# Inspect directory storage in current directory
alias inspect="du -d 1 -h | sort -h"

# Generate random values of different types
alias randhex='python3 ~/dev/dotfiles-setup/scripts/random_values.py hex'
alias randstr='python3 ~/dev/dotfiles-setup/scripts/random_values.py str'
alias randint='python3 ~/dev/dotfiles-setup/scripts/random_values.py int'
