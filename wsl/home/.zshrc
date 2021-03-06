# common--------------------------------------------------
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# set
setopt +o nomatch
# export
export SHELL=/usr/bin/zsh
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
# alias
alias vi=nvim
alias vis='nvim -S'
alias memo='nvim ~/memo/$(date "+%Y%m%d").md'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# prezto
autoload -Uz promptinit
promptinit
prompt steeef

# /common-------------------------------------------------
# wsl--------------------------------------------------
export PATH=$PATH:/usr/local/go/bin
# /wsl-------------------------------------------------
