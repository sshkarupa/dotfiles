## My Dotfiles

### Instalation

```
git clone git@github.com:sshkarupa/dotfiles.git ~/.dotfiles
```

### Symlinks config

1. git
```
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/pre-commit ~/.git_template/hooks/pre-commit
```

2. ssh [TODO]
```
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
```

3. tmux
```
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

4. vim
```
mkdir -p  ~/.vim/autoload
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim-plug/plug.vim ~/.vim/autoload/plug.vim
```

5. zsh
```
ln -s ~/.dotfiles/zsh ~/.zsh
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
```

### TODO

1. Add ssh_config
2. Add gitignore_global
3. Add install.sh
