" Vim configuration file, in effect when invoked as "vi". The aim of this
" configuration file is to provide a Vim environment as compatible with the
" original vi as possible. Note that ~/.vimrc configuration files as other
" configuration files in the runtimepath are still sourced.
" When Vim is invoked differently ("vim", "view", "evim", ...) this file is
" _not_ sourced; /etc/vim/vimrc and/or /etc/vim/gvimrc are.

" Debian system-wide default configuration Vim
 set nocompatible               " be iMproved
 filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'tpope/vim-rails.git'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'nanotech/jellybeans.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mileszs/ack.vim'

filetype plugin indent on     " required!

set tabstop=2
set shiftwidth=2
set expandtab
set wildmode=longest,list,full
set nu

autocmd BufWritePre * :FixWhitespace
autocmd FileWritePre * :FixWhitespace

map <F2> :FixWhitespace<CR>
map! <F2> :FixWhitespace<CR>

colorscheme jellybeans

set backupdir=~/.vimtmp//
set directory=~/.vimtmp//

" vim: set ft=vim:
