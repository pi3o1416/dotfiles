#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PS1="\[\033[38;5;189m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\] [\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;191m\]\u@\h\[$(tput sgr0)\]] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;81m\]\W\[$(tput sgr0)\]\[\033[38;5;191m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

export PATH=$PATH:$HOME/bin:$HOME/go/bin

# Terminal truecolor
export TERM=xterm-256color

# Python virtual env

activate() {
    current_dir=$(pwd)
    home_dir="$HOME"

    while [[ "$current_dir" != "$home_dir" ]]; do
        source_path="${current_dir}/venv/bin/activate"
        if [[ -f "$source_path" ]]; then
            source "$source_path"
            return 0
        fi
        current_dir=$(dirname "$current_dir")
    done
    return 1
}

# Call the activate function
activate

# ffmpeg
alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffplay -hide_banner -autoexit'
alias ffprobe='ffprobe -hide_banner'

export GO111MODULE=on
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

