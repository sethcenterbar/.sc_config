RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# echo "I ${RED}love${NC} Stack Overflow\n" example


#! /bin/bash
cd ~
echo "Starting symlinker setup"
echo "..."

# Download OH-MY-ZSH!
if [ ! -d ~/.oh-my-zsh ]; then
	echo "${YELLOW}Downloading Oh-My-Zsh!${NC}"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo "${GREEN}Oh-My-ZSH already installed${NC}"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
	echo "${YELLOW}Downloading Oh-My-Zsh autosuggestions plugin !${NC}"
	sh -c "$(git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions)"
else
	echo "${GREEN}Oh-My-ZSH autosuggestions plugin already installed${NC}"
fi


if [ ! -d ~/.fzf ]; then
	echo "${YELLOW}Downloading junegunn/fzf${NC}"
	sh -c "$(git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf)"
	sh -c "$(~/.fzf/install)"
else
	echo "${GREEN}fzf already installed!${NC}"
fi


# Vim-Plug Setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	echo "${YELLOW}Installing vim-plug files${NC}"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
	echo "${GREEN}vim-plug files already installed${NC}"
fi

# Symlink Custom theme into .oh-my-zsh/
if [ ! -e ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme ]; then
	echo "${YELLOW}creating dstcustom.zsh-theme"
	ln -s ${HOME}/.sc_config/themes/dstcustom.zsh-theme ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme
else
	echo "${GREEN} dstcustom.zsh-theme exists in .oh-my-zsh/themes ${NC}"
	if [ ! -L ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme ]; then
		echo "${YELLOW} dstcustom.zsh-theme isn't a simlink, fixing.."
		rm ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme
		ln -s ${HOME}/.sc_config/themes/dstcustom.zsh-theme ${HOME}/.oh-my-zsh/themes/dstcustom.zsh-theme
	else
		echo "${GREEN} dstcustom.zsh-theme is a simlink!${NC}"
	fi
fi

		


# Create/Symlink all files in ${HOME} 
declare -a arr=(".zshrc"
								".vimrc"
								".fzfrc"
								".tmux.conf"
								)

for i in "${arr[@]}"
do
	if [ ! -e ${HOME}/$i ]; then
		echo "${YELLOW}creating " $i "${NC}"
		ln -s .sc_config/$i $i
	else
		echo "${GREEN}" $i " exists ${NC}"
		if [ ! -L ${HOME}/$i ]; then
			echo "${YELLOW}" $i " is not a symlink ${NC}"
			rm $i
			ln -s .sc_config/$i $i
		else
			echo "${GREEN} " $i "  is a symlink${NC}"
		fi
	fi
done

declare -a nvim_arr=("coc-settings.json"
					"coc.vim"
					"init.vim"
					"theme.vim"
				)

for j in "${nvim_arr[@]}"
do
	if [ ! -e ${HOME}/.config/nvim/$j ]; then
		echo "${YELLOW}creating " $j "${NC}"
		ln -s ${HOME}/.sc_config/nvim/$j ${HOME}/.config/nvim/$j
	else
		echo "${GREEN}" $j " exists ${NC}"
		if [ ! -L ${HOME}/.config/nvim/$j ]; then
			echo "${YELLOW}" $j " is not a symlink ${NC}"
			rm $j
			ln -s ${HOME}/.sc_config/nvim/$j ${HOME}/.config/nvim/$j
		else
			echo "${GREEN} " $j "  is a symlink${NC}"
		fi
	fi
done


