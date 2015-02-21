" Debian system-wide default configuration Vim
set nocompatible               " be iMproved
filetype off                   " required!

set encoding=utf-8

" OS X tweak
syntax enable

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" don't vungle with my Vungle
Plugin 'gmarik/Vundle.vim'

" tpope is the man
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-bundler'

" more mvment
Plugin 'bkad/CamelCaseMotion'

" rails stuff
Plugin 'thoughtbot/vim-rspec'
Plugin 'adammathys/vim-dispatch'
Plugin 'int3/vim-extradite'

" make preetty
Plugin 'nanotech/jellybeans.vim'
Plugin 'rking/vim-detailed'

Plugin 'kchmck/vim-coffee-script'
Plugin 'briancollins/vim-jst'
Plugin 'yaymukund/vim-rabl'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cakebaker/scss-syntax.vim'

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'sjl/gundo.vim'

" fzy stuff
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Dkendal/fzy-vim'

filetype plugin indent on     " required!

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

set tabstop=2
set shiftwidth=2
set expandtab

if has("autocmd")
  " set preferred spacing for these filetypes
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType haml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
end

set wildmode=longest,list,full
set nu
set hlsearch
set ls=2
set splitright
set splitbelow

" autocmd BufWritePre * :FixWhitespace
" autocmd FileWritePre * :FixWhitespace

" Make tab/space characters visible
set listchars=tab:▸\ ,trail:·,nbsp:¬,eol:¶,extends:»,precedes:«

colorscheme jellybeans

set backupdir=~/.vimtmp//
set directory=~/.vimtmp//

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Custom key maps
let mapleader = ' '

nnoremap <Leader>e :FzyLsAg<CR>
nnoremap <Leader>f :SFzyLsAg<CR>
nnoremap <Leader>F :VFzyLsAg<CR>
nnoremap <Leader>G :VFzyGem<CR>

map <Leader>W :FixWhitespace<CR>

" Dispatch stuff
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :Dispatch rspec-fast<CR>

map <Leader>E :Extradite<CR>
map <Leader>B :Gblame<CR>

" .vimrc editing made easy
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>

" Indent/outdent block
nmap %% $>i}``
nmap $$ $<i}``

" Functions {{{1
function! CtrlPGem()
  let gem= input('gem name: ')
  let gem_path= system('bundle show ' . gem)
  let stripped_gem_path= substitute(gem_path,"\n","","g")
  execute(':CtrlP ' . stripped_gem_path)
endfunction

function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction
"}}}1

" Commmands {{{1
command! CtrlPGem :call CtrlPGem()
"}}}1

" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <Leader><Leader>md :!google-chrome-unstable %:p<CR>'

" Setup Ctrl-P search to use ag
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"RSpec + Dispatch!
let g:rspec_command = 'Dispatch bundle exec rspec {spec}'

"Dispatch compilers
let g:dispatch_compilers = { 'rspec-fast' : 'rspec',
                           \ 'bundle exec': '' }

" Highlight background after 80 chars
let &colorcolumn=join(range(81,999),",")

" Ag search options
let g:agprg = 'ag --nogroup --nocolor --column'

" vim: set ft=vim:
