RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# echo -e "I ${RED}love${NC} Stack Overflow\n" example


#! /bin/bash
cd ~
echo -e "Starting symlinker setup"
echo -e "..."

# Download OH-MY-ZSH!
if [ ! -d ~/.oh-my-zsh ]; then
	echo -e "${YELLOW}Downloading Oh-My-Zsh!${NC}"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo -e "${GREEN}Oh-My-ZSH already installed${NC}"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	echo -e "${YELLOW}Downloading Oh-My-Zsh autosuggestions plugin !${NC}"
	sh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)"
else
	echo -e "${GREEN}Oh-My-ZSH autosuggestions plugin already installed${NC}"
fi


if [ ! -d ~/.fzf ]; then
	echo -e "${YELLOW}Downloading junegunn/fzf${NC}"
	sh -c "$(git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf)"
	sh -c "$(~/.fzf/install)"
else
	echo -e "${GREEN}fzf already installed!${NC}"
fi


# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	echo -e "${YELLOW}Installing vim-plug files${NC}"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
	echo -e "${GREEN}vim-plug files already installed${NC}"
fi

# Symlink Custom theme into .oh-my-zsh/
if [ ! -L ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme ]; then
	ln -s ${HOME}/.sc_config/themes/dstcustom.zsh-theme ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme
fi


# Create/Symlink all files in ${HOME} 
declare -a arr=(".zshrc"
								".vimrc"
								".fzfrc"
								".tmux.conf"
								"notes"
								)

for i in "${arr[@]}"
do
	if [ ! -e ${HOME}/$i ]; then
		echo -e "${YELLOW}creating " $i "${NC}"
		ln -s .sc_config/$i $i
	else
		echo -e "${GREEN}" $i " exists {$NC}"
		if [ ! -L ${HOME}/$i ]; then
			echo -e "${YELLOW}" $i " is not a symlink ${NC}"
			rm $i
			ln -s .sc_config/$i $i
		else
			echo -e "${GREEN} " $i "  is a symlink${NC}"
		fi
	fi
done


