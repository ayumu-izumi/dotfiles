"common----------------------------------------------------
"file
set noswapfile
set nobackup

"view
set showtabline=2
set number
set hlsearch
set cursorline
set list
set listchars=tab:»-,trail:-,nbsp:%

"edit
set cindent
set tabstop=4
set shiftwidth=4
vnoremap * "zy:let @/ = @z<CR>n

"plugin
if &compatible
	set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')
	call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
	call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
	call#end()
	call dein#save_state()
endif
if dein#check_install()
	call dein#install()
endif
filetype plugin indent on
syntax enable
"/common---------------------------------------------------
"mac-------------------------------------------------------
"nerdtree-git
set shell=/usr/local/bin/zsh
