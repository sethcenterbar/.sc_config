# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
zsh
exit

# added by travis gem
[ -f /Users/sethcenterbar/.travis/travis.sh ] && source /Users/sethcenterbar/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
