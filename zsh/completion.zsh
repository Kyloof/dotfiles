# mark compitinit as autoloadable
autoload -U compinit

# init completion system
compinit

# include dotfiles in completion system
_comp_options+=(globdots)
