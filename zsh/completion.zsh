# Mark compitinit as autoloadable
autoload -U compinit

# Init completion system
compinit

# Include dotfiles in completion system
_comp_options+=(globdots)

# Set the order of which zsh will try to complete commands
zstyle ':completion:*' completer _extensions _complete _approximate

# Cache the completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Add interactive menu when pressing <TAB>
zstyle ':completion:*' menu yes select interactive


zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
