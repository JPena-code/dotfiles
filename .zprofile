export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.cache"

# Custom always have to go aliases for
alias c="clear"
alias ls="ls --color=auto"
alias k="kubctl"
alias h="helm"

# TODO: move to nvim in the future learn about it
export EDITOR="vim"
export SHELL="zsh"

# If you come from bash you might have to change your $PATH.
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/sbin"

# Set pyenv root path to .config dont let in home
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

