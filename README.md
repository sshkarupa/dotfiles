## My Dotfiles

### Instalation

```
git clone git@github.com:sshkarupa/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
git submodules init
git submodules update
```

### Symlinks config

#### Git

```
mkdir -p ~/.git_template/hooks
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/pre-commit ~/.git_template/hooks/pre-commit
```

#### Tmux

```
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

#### Vim

```
mkdir -p  ~/.vim/autoload
mkdir -p ~/.vim/spell
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/plugins.vim ~/.vim/plugins.vim
ln -s ~/.dotfiles/vim/vim-plug/plug.vim ~/.vim/autoload/plug.vim
```

#### Zsh

```
ln -s ~/.dotfiles/zsh ~/.zsh
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
```
