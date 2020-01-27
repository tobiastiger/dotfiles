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


git_setup_debian() {
  apt-get -y install software-properties-common
  add-apt-repository ppa:git-core/ppa
  apt-get update
  apt-get install -y git

  git clone https://github.com/tobiastiger/dotfiles.git $homedir/dotfiles

  ln -sf $homedir/dotfiles/git/gitconfig $homedir/.gitconfig

  chown -R $user:$group $homedir/dotfiles $homedir/.gitconfig
}


nvim_setup_debian() {
  apt-get update
  apt-get install -y neovim

  ln -sf $homedir/dotfiles/nvim/nvim $homedir/.config/nvim

  git clone https://github.com/k-takata/minpac.git $homedir/.config/nvim/pack/minpac/opt/minpac

  chown -R $user:$group $homedir/.config/nvim
}


tmux_setup_debian() {
  apt-get update
  apt-get install -y tmux

  git clone https://github.com/tmux-plugins/tpm $homedir/.tmux/plugins/tpm

  ln -sf $homedir/dotfiles/tmux/tmux.conf $homedir/.tmux.conf

  chown -R $user:$group $homedir/.tmux $homedir/.tmux.conf
}


zsh_setup_debian() {
  apt-get update
  apt-get install -y zsh

  git clone https://github.com/robbyrussell/oh-my-zsh.git $homedir/.oh-my-zsh

  git clone https://github.com/denysdovhan/spaceship-prompt.git $homedir/.oh-my-zsh/custom/themes/spaceship-prompt

  ln -sf $homedir/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $homedir/.oh-my-zsh/custom/themes/spaceship.zsh-theme

  ln -sf $homedir/dotfiles/zsh/zshrc $homedir/.zshrc

  chown -R $user:$group $homedir/.oh-my-zsh $homedir/.zshrc
}


main() {
  if [ "$os" = "Linux" ]; then
    if [ "$cmd" = "all" ]; then
      printf "Setting up dotfiles\n"
      git_setup_debian
      nvim_setup_debian
      tmux_setup_debian
      zsh_setup_debian
    fi

    if [ "$cmd" = "git" ]; then
      printf "Setting up git\n"
      git_setup_debian
    fi

    if [ "$cmd" = "nvim" ]; then
      printf "Setting up neovim\n"
      nvim_setup_debian
    fi
    
    if [ "$cmd" = "tmux" ]; then
      printf "Setting up tmux\n"
      tmux_setup_debian
    fi

    if [ "$cmd" = "zsh" ]; then
      printf "Setting up zsh\n"
      zsh_setup_debian
    fi

    printf "Done\n"
  fi
}

main
