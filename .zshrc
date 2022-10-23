source ~/.zplug/init.zsh

# Can manage local plugins
zplug "~/.zsh", from:local

# Load theme file
zplug 'agnoster/agnoster-zsh-theme', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

#PS1='[\u@\h \W]\$ '

# tilix: fixing tilix issue
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

#Custom binary files
export PATH="/home/monir/bin:$PATH"
export PATH="/home/monir/.local/bin:$PATH"
. "$HOME/.cargo/env"
