# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

source "$HOME/.zprofile"

# Create config folder for programs that
# desn't create its folder if not exists
[[ -d "$XDG_DATA_HOME/psql" ]] || mkdir -p "$XDG_DATA_HOME/psql"

# Change compinit dumpfiles location
export ZSH_COMPDUMP="$XDG_DATA_HOME/zsh/zcompdump"
[[ -d "$ZSH_COMPDUMP" ]] || mkdir -p "$ZSH_COMPDUMP"

# Set the GPG TTY to be the same as the current one
export GPG_TTY="$TTY"

# Export path to SQL server tools if path is found
[[ -d "/opt/mssql-tools*/bin" ]] && export $PATH="$PATH:/opt/mssql-tools18/bin"

# Download zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p $(dirname "$ZINIT_HOME")
  git clone -q  https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Instanll pyenv python manager
# use github recomended installtion that alredy ships 3 prluing
# virtualenv, update, doctor
[[ ! -f "$PYENV_ROOT/bin/pyenv" ]] && { curl -sSLf https://pyenv.run | bash } 2>&1 1>/dev/null
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Powerlevel10k theme instalation
zinit ice depth=1; zinit light romkatv/powerlevel10k

# installing it from zinit  makes them lack of a man
# page, installad from git source for the latest version
# and use `as'null'` to avoid modifications in $PATH
zinit wait'1' silent-mode as"null" nocompile \
  from"gh-r" \
  mv"fzf -> $ZPFX/bin" \
  blockf \
  atload'eval "$(fzf --zsh)"' for \
    junegunn/fzf

# Install fnm Node manager
zinit wait'2' lucid silent-mode as'null' \
  mv"fnm -> $ZPFX/bin" \
  atload'eval "$(fnm env --use-on-cd --shell zsh)"' \
  from"gh-r" for \
    Schniz/fnm

# Install pnpm Node package manager
zinit wait'3' lucid silent-mode as'null' \
  from'gh-r' \
  atload'pnpm completion zsh > _pnpm; source _pnpm' \
  blockf \
  mv"pnpm* -> $ZPFX/bin/pnpm" for \
    pnpm/pnpm

# Three most commont zsh zinit plugins
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab

# OMZ snippet pluings
zinit lucid silent-mode for \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::sudo \
  OMZP::command-not-found \
  OMZP::fnm

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History options
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# zstyle for completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors  '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias pn=pnpm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

