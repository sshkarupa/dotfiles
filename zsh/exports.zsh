export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

export TERM="xterm-256color"
export EDITOR='vim'

# if rbenv is present, configure it for use
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - zsh)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

export PATH="/usr/local/share/npm/bin:$PATH"

export PATH="/usr/local/heroku/bin:$PATH"

# if pyenv is present, configure it for use
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init - zsh)"
fi

export ANTIGEN_COMPDUMPFILE=$HOME/.zcompdump
