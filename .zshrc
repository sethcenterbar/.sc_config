export ZSH=~/.oh-my-zsh
export ZSHRC_PYTHON_PATH=$(which python3)
export EDITOR='vim'
export PATH=/Users/sethcenterbar/.deno/bin/:$PATH
export REPORTTIME=10

ZSH_THEME="dstcustom"

plugins=(
  git 
	last-working-dir 
	colored-man-pages 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.fzf/bin/fzf ]; then # Add programs to path if needed
	path+=~/.fzf/bin/
fi

if [ -f ~/.fzfrc ]; then # Import my fzf cmds if present
	source ~/.fzfrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # fzf zsh autocompletion

# Custom Aliases
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias sz="source ~/.zshrc"
alias grep='grep -i --color'
alias vim='nvim'
alias nvimrc='vim ~/.config/nvim/init.vim'

# Key bindings
bindkey -r "^O" # Unbind ctrl-o, which i'm going to use in tmux
# If I wanted to bind a key, it would look like bindkey "^O" some-zsh-command


# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
