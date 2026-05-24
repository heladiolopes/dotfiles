# Cleanup helpers
alias inspect="du -d 1 -h | sort -h"
alias flushpoetry="poetry cache list | awk '{print \$1}' | xargs -I {} poetry cache clear --all {}"
alias flushpip="pip cache purge"
alias flushpyc="find . -type d -name '__pycache__' -exec rm -r {} + && find . -type f -name '*.pyc' -delete"
alias flushgo="go clean -cache"
alias flushprecommit="pre-commit clean"
alias flushuv="uv cache clean"
