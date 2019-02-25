echo "Pulling most recent sc_config"
cd ~/.sc_config
git pull
cd ~
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSHRC_PYTHON_PATH=$(which python3)

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
alias vg="vim -c 'Goyo' "
alias lyn="learnyounode"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sethcenterbar/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sethcenterbar/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sethcenterbar/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sethcenterbar/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/sethcenterbar/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
