# freebsd-mokka: Zsh configuration

# Keep history across sessions without recording duplicate consecutive entries.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Sensible interactive defaults.
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Portable aliases.
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'

# Starship prompt.
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
