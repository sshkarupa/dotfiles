#!/bin/bash

function pull {
  cd $DOTFILE_DIR
  git pull origin master
  git submodule init
  git submodule update
}

function update {
  if [ "$noUpdate" == 'false' ]; then
    if [ "$autoUpdate" == 'true' ]; then
      sudo apt-get install "$@"
    elif [ "$autoUpdate" == 'false' ]; then
      echo "Do you want to update $@?"
      read update
      if [ "$update" == y ]; then
        sudo apt-get install "$@"
      fi
    fi
  fi
}

function link {
  if [ "$forseLN" = 'true' ]; then
    ln -sf $1 $2
  else
    if [[ -e "$2" ]]; then
      echo "$2 already exists, if it is a symlink it will be deleted"
      if [[ -h "$2" ]]; then
        rm -rf "$2"
        ln -s $1 $2
      else
        echo "Not a symlink, renaming and linking"
        mv -f "$2" "$2_old"
        ln -s $1 $2
      fi
    else
      ln -s $1 $2
    fi
  fi
}

function installConfigs {
  # ZSH
  update zsh
  echo "Installing ZSH Config"
  link $DOTFILE_DIR/zsh ~/.zsh
  link $DOTFILE_DIR/zsh/zshrc ~/.zshrc
  if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s $(which zsh)
  fi
  echo ""

  # Git
  update git
  echo "Installing Git Config"
  mkdir -p ~/.git_template/hooks
  link $DOTFILE_DIR/git/gitconfig ~/.gitconfig
  link $DOTFILE_DIR/git/pre-commit ~/.git_template/hooks/
  echo ""

  # Tmux
  update tmux
  echo "Installing Tmux Config"
  link $DOTFILE_DIR/tmux/tmux.conf ~/.tmux.conf
  echo ""

  # Vim
  update vim
  echo "Installing VIM config"
  mkdir -p  ~/.vim/{autoload,spell}
  link $DOTFILE_DIR/vim/vimrc ~/.vimrc
  link $DOTFILE_DIR/vim/vim-plug/plug.vim ~/.vim/autoload/
  link $DOTFILE_DIR/vim/UltiSnips ~/.vim/
  link $DOTFILE_DIR/vim/plugins.vim ~/.vim/
  vim +PlugInstall +qall
  echo ""
}

function main {
  noLN='false'
  autoUpdate='false'
  forseLN='false'
  noUpdate='false'

  while getopts 'nufi' flag; do
    case "${flag}" in
      n) noLN='true' ;;
      u) autoUpdate='true' ;;
      f) forseLN='true' ;;
      i) noUpdate='true' ;;
      *) error "Unexpected option ${flag}" ;;
    esac
  done

  DOTFILE_DIR="$HOME/.dotfiles"

  if [ "$noLN" == 'true' ]; then
    pull
  elif [ "$noLN" == 'false' ]; then
    pull
    installConfigs
  fi
}

main "$@"
