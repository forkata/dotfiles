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
Bundle 'bkad/CamelCaseMotion'
Bundle 'kien/ctrlp.vim'
Bundle 'Dkendal/fzy-vim'
Bundle 'yaymukund/vim-rabl'

filetype plugin indent on     " required!

set tabstop=2
set shiftwidth=2
set expandtab

set wildmode=longest,list,full
set nu
set hlsearch
set splitright
set splitbelow

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

nnoremap <Leader><Leader>F :VFzyLsAg<CR>
nnoremap <Leader><Leader>G :VFzyGem<CR>

" Functions {{{1
function! CtrlPGem()
  let gem= input('gem name: ')
  let gem_path= system('bundle show ' . gem)
  let stripped_gem_path= substitute(gem_path,"\n","","g")
  execute(':CtrlP ' . stripped_gem_path)
endfunction
"}}}1

" Commmands {{{1
command! CtrlPGem :call CtrlPGem()
"}}}1

" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F5> :!google-chrome %:p<CR>'

" Setup Ctrl-P search to use ag
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

let &colorcolumn=join(range(81,999),",")
let g:agprg = 'ag --nogroup --nocolor --column'

" vim: set ft=vim:
