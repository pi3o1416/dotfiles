#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PS1="\[\033[38;5;189m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\] [\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;191m\]\u@\h\[$(tput sgr0)\]] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;81m\]\W\[$(tput sgr0)\]\[\033[38;5;191m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

export PATH=$PATH:$HOME/bin

activate() {
    current_dir=$(pwd)
    IFS='/' read -ra parts <<< "$current_dir"
    path_joined=$(printf '/%s' "${parts[@]:0:8}")
    path_joined=${path_joined:1}
    source_path="${path_joined}/venv/bin/activate"
    
    # Check if the source_path exists
    if [[ -f "$source_path" ]]; then
        source "$source_path"
    else
        return 1
    fi
}

# Call the activate function
activate
