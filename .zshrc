echo "Pulling most recent sc_config"
cd ~/.sc_config
git pull
cd ~
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSHRC_PYTHON_PATH=$(which python3)
export EDITOR='vim'

# Auto update zsh
DISABLE_UPDATE_PROMPT=true

# 
export REPORTTIME=1

ZSH_THEME="dstcustom"

plugins=(
  git 
	last-working-dir 
	colored-man-pages 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source ~/.bin/tmuxinator.zsh

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

if [ -f /Users/sethcenterbar/Library/Python/3.7/bin/aws ]; then
	path+=/Users/sethcenterbar/Library/Python/3.7/bin/
fi

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

# Custom Aliases
alias lo='locate'
alias hg="history | grep "
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias x="exit"
alias sz="source ~/.zshrc"
alias grep='grep -i --color'
alias al="cat ~/.zshrc | grep -v '#' | grep alias"
alias alg="cat ~/.zshrc | grep -v '#' | grep alias | grep "
alias tree='tree -C'
alias ml='mongolog'
alias gah="sudo !!"
alias sudo='sudo env PATH=$PATH'
alias hg='history | grep'
alias svim='sudo vim -u ~/.vimrc'
alias sc='systemctl'
alias ssc='sudo systemctl'
alias sscs='sudo systemctl status'
alias sscr='sudo systemctl restart'
alias rhelpy='scl enable rh-python36 $(which zsh)'
alias vg="vim -c 'Goyo' "
alias dirs="dirs -v"
alias yt="mpsyt"
alias cleanconf='egrep -v "^\s*(#|$)"'
alias emacs='/usr/local/Cellar/emacs/26.2/bin/emacs'
