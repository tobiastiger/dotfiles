#!/bin/bash

set -e
set -o pipefail

os=$(uname)

if [ "$os" = "Linux" ]; then
  if [ $(id -u) -ne 0 ]; then
    printf "Please run as root.\n"
    exit
  else
    user=$SUDO_USER
  fi
elif [ "$os" = "Darwin" ]; then
  user=$USER
fi

group=$(id -gn $user)
homedir=$HOME

cmd="all"
while :; do
  case $1 in
    -c|--command)   cmd=$2;;
    *) break
  esac
  shift
done


alacritty_setup_debian() {
  add-apt-repository -y ppa:mmstick76/alacritty
  apt-get install alacritty

  if [ ! -d $homedir/.config/alacritty ]; then
    mkdir $homedir/.config/alacritty
  fi

  ln -sf $homedir/dotfiles/alacritty/alacritty.yml $homedir/.config/alacritty/alacritty.yml

  chown -R $user:$group $homedir/.config/alacritty 
}


alacritty_setup_macos() {
  brew cask install alacritty

  if [ ! -d $homedir/.config/alacritty ]; then
    mkdir $homedir/.config/alacritty
  fi

  ln -sf $homedir/dotfiles/alacritty/alacritty.yml $homedir/.config/alacritty/alacritty.yml
}


git_setup_debian() {
  apt-get -y install software-properties-common
  add-apt-repository ppa:git-core/ppa
  apt-get update
  apt-get install -y git

  if ! git clone https://github.com/tobiastiger/dotfiles.git $homedir/dotfiles 2>/dev/null && [ -d $homedir/dotfiles ]; then
      echo "dotfiles folder already exists; git clone aborted."
  fi

  ln -sf $homedir/dotfiles/git/gitconfig $homedir/.gitconfig

  chown -R $user:$group $homedir/dotfiles $homedir/.gitconfig
}


git_setup_macos() {
  if brew ls --versions git > /dev/null; then
    brew upgrade git
  else
    brew install git
  fi

  if ! git clone https://github.com/tobiastiger/dotfiles.git $homedir/dotfiles 2>/dev/null && [ -d $homedir/dotfiles ]; then
      echo "dotfiles folder already exists; git clone aborted."
  fi

  ln -sf $homedir/dotfiles/git/gitconfig $homedir/.gitconfig
}


nvim_setup_debian() {
  apt-get update
  apt-get install -y neovim

  ln -sf $homedir/dotfiles/nvim/nvim $homedir/.config/nvim

  minpac_folder=$homedir/.config/nvim/pack/minpac/opt/minpac

  if ! git clone https://github.com/k-takata/minpac.git $minpac_folder 2>/dev/null && [ -d $minpac_folder ]; then
      echo "minpac folder already exists; git clone aborted."
  fi

  chown -R $user:$group $homedir/.config/nvim $homedir/dotfiles/nvim/nvim/nvim
}

nvim_setup_macos() {
  if brew ls --versions neovim > /dev/null; then
    brew upgrade neovim
  else
    brew install neovim
  fi

  ln -sf $homedir/dotfiles/nvim/nvim $homedir/.config/nvim

  minpac_folder=$homedir/.config/nvim/pack/minpac/opt/minpac

  if ! git clone https://github.com/k-takata/minpac.git $minpac_folder 2>/dev/null && [ -d $minpac_folder ]; then
      echo "minpac folder already exists; git clone aborted."
  fi
}


tmux_setup_debian() {
  apt-get update
  apt-get install -y tmux

  tpm_folder=$homedir/.tmux/plugins/tpm

  if ! git clone https://github.com/tmux-plugins/tpm $tpm_folder 2>/dev/null && [ -d $tpm_folder ]; then
      echo "tpm folder already exists; git clone aborted."
  fi

  ln -sf $homedir/dotfiles/tmux/tmux.conf $homedir/.tmux.conf

  chown -R $user:$group $homedir/.tmux $homedir/.tmux.conf
}


tmux_setup_macos() {
  if brew ls --versions tmux > /dev/null; then
    brew upgrade tmux
  else
    brew install tmux
  fi

  tpm_folder=$homedir/.tmux/plugins/tpm

  if ! git clone https://github.com/tmux-plugins/tpm $tpm_folder 2>/dev/null && [ -d $tpm_folder ]; then
      echo "tpm folder already exists; git clone aborted."
  fi

  ln -sf $homedir/dotfiles/tmux/tmux.conf $homedir/.tmux.conf
}


zsh_setup_debian() {
  apt-get update
  apt-get install -y zsh

  oh_my_zsh_folder=$homedir/.oh-my-zsh
  spaceship_folder=$homedir/.oh-my-zsh/custom/themes/spaceship-prompt

  if ! git clone https://github.com/robbyrussell/oh-my-zsh.git $oh_my_zsh_folder 2>/dev/null && [ -d $oh_my_zsh_folder ]; then
      echo "oh-my-zsh folder already exists; git clone aborted."
  fi

  if ! git clone https://github.com/denysdovhan/spaceship-prompt.git $spaceship_folder 2>/dev/null && [ -d $spaceship_folder ]; then
      echo "Spaceship prompt folder already exists; git clone aborted."
  fi

  ln -sf $homedir/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $homedir/.oh-my-zsh/custom/themes/spaceship.zsh-theme

  ln -sf $homedir/dotfiles/zsh/zshrc $homedir/.zshrc

  chown -R $user:$group $homedir/.oh-my-zsh $homedir/.zshrc
}


zsh_setup_macos() {
  if brew ls --versions zsh > /dev/null; then
    brew upgrade zsh
  else
    brew install zsh
  fi

  oh_my_zsh_folder=$homedir/.oh-my-zsh
  spaceship_folder=$homedir/.oh-my-zsh/custom/themes/spaceship-prompt

  if ! git clone https://github.com/robbyrussell/oh-my-zsh.git $oh_my_zsh_folder 2>/dev/null && [ -d $oh_my_zsh_folder ]; then
      echo "oh-my-zsh folder already exists; git clone aborted."
  fi

  if ! git clone https://github.com/denysdovhan/spaceship-prompt.git $spaceship_folder 2>/dev/null && [ -d $spaceship_folder ]; then
      echo "Spaceship prompt folder already exists; git clone aborted."
  fi

  ln -sf $homedir/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $homedir/.oh-my-zsh/custom/themes/spaceship.zsh-theme

  ln -sf $homedir/dotfiles/zsh/zshrc $homedir/.zshrc
}

main() {
  if [ "$os" = "Linux" ]; then
    if [ "$cmd" = "all" ]; then
      echo "Setting up dotfiles..."
      git_setup_debian
      alacritty_setup_debian
      nvim_setup_debian
      tmux_setup_debian
      zsh_setup_debian
    fi

    if [ "$cmd" = "alacritty" ]; then
      echo "Setting up alacritty..."
      alacritty_setup_debian
    fi

    if [ "$cmd" = "git" ]; then
      echo "Setting up git..."
      git_setup_debian
    fi

    if [ "$cmd" = "nvim" ]; then
      echo "Setting up neovim..."
      nvim_setup_debian
    fi
    
    if [ "$cmd" = "tmux" ]; then
      echo "Setting up tmux..."
      tmux_setup_debian
    fi

    if [ "$cmd" = "zsh" ]; then
      echo "Setting up zsh..."
      zsh_setup_debian
    fi

    printf "Done.\n"
  fi

  if [ "$os" = "Darwin" ]; then
    if [ "$cmd" = "all" ]; then
      echo "Setting up dotfiles..."
      git_setup_macos
      alacritty_setup_macos
      nvim_setup_macos
      tmux_setup_macos
      zsh_setup_macos
    fi

    if [ "$cmd" = "alacritty" ]; then
      echo "Setting up alacritty..."
      alacritty_setup_macos
    fi

    if [ "$cmd" = "git" ]; then
      echo "Setting up git..."
      git_setup_macos
    fi

    if [ "$cmd" = "nvim" ]; then
      echo "Setting up neovim..."
      nvim_setup_macos
    fi
    
    if [ "$cmd" = "tmux" ]; then
      echo "Setting up tmux..."
      tmux_setup_macos
    fi

    if [ "$cmd" = "zsh" ]; then
      echo "Setting up zsh..."
      zsh_setup_macos
    fi
    printf "Done.\n"
  fi
}

main
