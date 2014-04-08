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
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'int3/vim-extradite'
Bundle 'tpope/vim-sleuth'
Bundle 'nanotech/jellybeans.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'briancollins/vim-jst'
Bundle 'mustache/vim-mode'
Bundle 'Lokaltog/powerline'
Bundle 'sjl/gundo.vim'
Bundle 'rking/vim-detailed'

filetype plugin indent on     " required!

set tabstop=2
set shiftwidth=2
set expandtab
set wildmode=longest,list,full
set nu
set hlsearch

" autocmd BufWritePre * :FixWhitespace
" autocmd FileWritePre * :FixWhitespace

map <F2> :FixWhitespace<CR>
map! <F2> :FixWhitespace<CR>

colorscheme jellybeans

set backupdir=~/.vimtmp//
set directory=~/.vimtmp//

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Syntax Highlight
" au BufNewFile,BufRead *.ejs set filetype=html

" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F5> :!google-chrome %:p<CR>'

let &colorcolumn=join(range(81,999),",")
let g:agprg = 'ag --nogroup --nocolor --column'

" vim: set ft=vim:
