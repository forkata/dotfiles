" Debian system-wide default configuration Vim
set nocompatible               " be iMproved
filetype off                   " required!

set encoding=utf-8

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
Plugin 'jarednorman/syntastic'

Plugin 'kchmck/vim-coffee-script'
Plugin 'briancollins/vim-jst'
Plugin 'yaymukund/vim-rabl'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'sjl/gundo.vim'

" fzy stuff
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Dkendal/fzy-vim'

filetype plugin indent on     " required!
syntax on

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_mode_map = { "mode": "passive" }

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
set fillchars+=vert:│

" autocmd BufWritePre * :FixWhitespace
" autocmd FileWritePre * :FixWhitespace

" Make tab/space characters visible
set listchars=tab:▸\ ,trail:·,nbsp:¬,eol:¶,extends:»,precedes:«

colorscheme jellybeans

set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Custom key maps
let mapleader = ' '

map <Leader>W :FixWhitespace<CR>

" Dispatch stuff
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :Dispatch rspec-fast<CR>

map <Leader>E :Extradite<CR>
map <Leader>B :Gblame<CR>
map <Leader>S :SyntasticCheck<CR>
map <Leader>R :SyntasticReset<CR>

" .vimrc editing made easy
nmap <silent> <Leader>c :vs $MYVIMRC<CR>
nmap <silent> <Leader>o :so $MYVIMRC<CR>

" Finish pivotal stories
nnoremap <Leader>p o<cr>[Finishes <esc>"*pA]]

" Indent/outdent block
nmap %% $>i}``
nmap $$ $<i}``

" Functions
function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
endfunction

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

" Fzy key maps
nnoremap <leader>e :call FzyCommand("ag . --nocolor -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("ag . --nocolor -l -g ''", ":vs")<cr>
nnoremap <leader>h :call FzyCommand("ag . --nocolor -l -g ''", ":sp")<cr>
nnoremap <leader>s :call FzyCommand("ag . --nocolor -l -g ''", ":sp")<cr>
nnoremap <leader>g :call FzyCommand("ag -g '' $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy))", ":vs")<cr>

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
let g:ag_prg = 'ag --nogroup --nocolor --column'

" vim: set ft=vim:
