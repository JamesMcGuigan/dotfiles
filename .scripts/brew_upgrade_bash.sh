# DOCS: https://apple.stackexchange.com/questions/371997/suppressing-the-default-interactive-shell-is-now-zsh-message-in-macos-catalina

brew update && brew install bash

# Intel
# sudo chsh -s /usr/local/bin/bash $(whoami)
# Apple M1 Silicon
sudo chsh -s /opt/homebrew/bin/bash $(whoami)