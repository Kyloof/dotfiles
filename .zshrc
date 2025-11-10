# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH

# MANPATH
export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH

# INFOPATH
export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH

export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME=""

# Updates
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# Visual Customisation
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
	git
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# Starship
eval "$(starship init zsh)"

# Exports
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"


# Alias
alias dtnet="cd ~/Studia/Semestr5/dotnet/labs/"
alias iot="cd ~/Studia/Semestr5/dotnet/labs"
alias albums="cd ~/Notes/personal/music/albums/2025"

