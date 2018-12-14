echo "Pulling most recent sc_config"
cd ~/.sc_config
git pull
cd ~
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSHRC_PYTHON_PATH=$(which python3)

ZSH_THEME="dst"

plugins=(
  git 
	last-working-dir 
	colored-man-pages 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Custom Functions
function mongolog() {
	if [ -f /var/log/mongodb/mongod.log ]; then
		tail -f /var/log/mongodb/mongod.log
	else
		echo "No log file at /var/log/mongodb/mongod.log"
	fi
}

function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

function lazypull() {
	cd ~/notes
	git reset --hard HEAD
	git clean -xffd
	git pull	
}

if [ -f ~/.tw_zshrc_confidential ]; then # work specific zsh config
	source ~/.tw_zshrc_confidential
fi

if [ -f ~/.fzf/bin/fzf ]; then # Add programs to path if needed
	path+=~/.fzf/bin/
fi

if [ -f ~/.fzfrc ]; then # Import my fzf cmds if present
	source ~/.fzfrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf zsh autocompletion


# # vi mode
# bindkey -v
# export KEYTIMEOUT=1

# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^r' history-incremental-search-backward

# zle -N zle-line-init
# zle -N zle-keymap-select

# # Beginning search with arrow keys
# bindkey "^[OA" up-line-or-beginning-search
# bindkey "^[OB" down-line-or-beginning-search
# bindkey -M vicmd "k" up-line-or-beginning-search
# bindkey -M vicmd "j" down-line-or-beginning-search

# function zle-keymap-select zle-line-init
# {
#     # change cursor shape in iTerm2
#     case $KEYMAP in
#         vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
#         viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
#     esac

#     zle reset-prompt
#     zle -R
# }

# function zle-line-finish
# {
#     print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
# }

# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select

# Custom Aliases
alias lo='locate'
alias hg="history | grep "
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias n="cd ~/notes; ll"
alias ncmd="grep \\\\$ "
alias ndir="grep /  "
alias npeek="grep '##' "
alias x="exit"
alias sz="source ~/.zshrc"
alias grep='grep -i --color'
alias al="cat ~/.zshrc | grep -v '#' | grep alias"
alias alg="cat ~/.zshrc | grep -v '#' | grep alias | grep "
alias tree='tree -C'
alias ß´†˙='echo "this shit works lol"'
alias ml='mongolog'
alias ss="./box_jumper.sh"
alias gah="sudo !!"
alias sudo='sudo env PATH=$PATH'
alias hg='history | grep'
alias svim='sudo vim -u ~/.vimrc'
alias sc='systemctl'
alias ssc='sudo systemctl'
alias rhelpy='scl enable rh-python36 $(which zsh)'
alias ec2='ssh -i "~/.ssh/EssentialsKP.pem" ec2-user@ec2-34-206-3-50.compute-1.amazonaws.com'
alias rhyme="python3 ~/scripts/rhyme.py"
