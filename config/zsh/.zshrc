# freebsd-mokka: Nusa Obsidian Zsh configuration

# History: shared across terminals, with useful duplicate handling.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt CORRECT

# Completion menu and case-insensitive matching.
autoload -Uz compinit
if [[ -d /usr/local/share/zsh/site-functions ]]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Nusa Obsidian colors for fuzzy finding.
export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border --color=fg:#e8e3da,bg:#17191b,hl:#b47750,fg+:#e8e3da,bg+:#292725,hl+:#d2b99a,info:#8f8175,prompt:#b47750,pointer:#b47750,marker:#d2b99a,spinner:#b47750,header:#8f8175,border:#51463d"

# Modern command-line tools (each is optional).
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first --git'
    alias ll='eza -lah --group-directories-first --git'
    alias la='eza -a --group-directories-first --git'
    alias tree='eza --tree --group-directories-first'
else
    alias ll='ls -lah'
    alias la='ls -A'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias v='nvim'
alias vim='nvim'
alias vi='nvim'

if command -v bat >/dev/null 2>&1; then
    alias c='bat --style=plain'
fi

# Smart directory jumping.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Fuzzy history (Ctrl+R), file search (Ctrl+T), and directory search (Alt+C).
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# Fish-like inline command suggestions.
if [[ -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8f8175'
fi

# Colorize commands as you type. Keep this last among Zsh plugins.
if [[ -r /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[command]='fg=#d2b99a'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#b47750'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#b47750'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#c76b61,bold'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#b47750,bold'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#e8e3da,underline'
fi

# Nusa prompt.
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# A compact system overview when a new interactive terminal opens.
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
