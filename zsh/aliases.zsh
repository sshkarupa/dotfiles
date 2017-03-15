alias sudo='sudo '
alias apt-get='apt-fast'

alias rm='rm -i'
alias wifirestart='sudo service network-manager restart'

alias got='git'
alias get='git'
alias gl='git log --pretty=format:"%an, %ar, %h: %s"'

alias be='bundle exec'
alias bes='bundle exec spring'

alias -s rb=vim # opens ruby files in vim
# $ foo.rb
# vim => foo.rb
alias -g gp='| grep -i' # creates a global alias for grep
# $ ps ax gp ruby
# (all ruby process will be displayed)

# Vagrant aliases
if which vagrant &> /dev/null; then
  alias vup="vagrant up"
  alias vh="vagrant halt"
  alias vs="vagrant suspend"
  alias vr="vagrant resume"
  alias vrl="vagrant reload"
  alias vssh="vagrant ssh"
  alias vst="vagrant status"
  alias vgst="vagrant global-status"
  alias vp="vagrant provision"
  alias vdstr="vagrant destroy"
  alias vbu="vagrant box update"
fi

# Apt-fast stuff
if which apt-fast &> /dev/null; then
  alias afi='sudo apt-fast install'
  alias afp='sudo apt-fast purge'
  alias afr='sudo apt-fast remove'
  alias afu='sudo apt-fast update'
  alias afug='sudo apt-fast upgrade'
  alias afuu='sudo apt-fast update && sudo apt-fast upgrade'
  alias afar='sudo apt-fast autoremove'
  alias afdu='sudo apt-fast dist-upgrade'
fi

# Apt-get stuff
if which apt-get &> /dev/null; then
  alias agi='sudo apt-get install'
  alias agp='sudo apt-get purge'
  alias agr='sudo apt-get remove'
  alias agu='sudo apt-get update'
  alias agug='sudo apt-get upgrade'
  alias aguu='sudo apt-get update && sudo apt upgrade'
  alias agar='sudo apt-get autoremove'
  alias agdu='sudo apt-get dist-upgrade'
fi
