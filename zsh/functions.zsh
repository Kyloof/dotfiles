# plugin management
function zsh_add_file() {
	[ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    if [ ! -d "$ZDOTDIR/plugins" ]; then
        mkdir "$ZDOTDIR/plugins"
    fi

	PLUGIN_NAME=${1#*/}
	if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
		zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin"
		zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    elif [ -f "$ZDOTDIR/plugins/$PLUGIN_NAME.zsh" ]; then
        zsh_add_file "plugins/$PLUGIN_NAME.zsh"
	else
		git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
	fi
}

# qol
function cl() {
    cd "$1"
    ls .
}
