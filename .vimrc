" Debian system-wide default configuration Vim
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" don't vungle with my Vungle
Plugin 'gmarik/Vundle.vim'

" tpope is the man
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" more mvment
Plugin 'bkad/CamelCaseMotion'
Plugin 'terryma/vim-multiple-cursors'

" rails stuff
Plugin 'thoughtbot/vim-rspec'
Plugin 'int3/vim-extradite'

" make preetty
Plugin 'nanotech/jellybeans.vim'
Plugin 'rking/vim-detailed'
Plugin 'NLKNguyen/papercolor-theme'

" linting
Plugin 'w0rp/ale'

" syntax highlighting
Plugin 'kchmck/vim-coffee-script'
Plugin 'briancollins/vim-jst'
Plugin 'yaymukund/vim-rabl'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elixir-lang/vim-elixir'
Plugin 'leafgarland/typescript-vim'
Plugin 'zerowidth/vim-copy-as-rtf'

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'sjl/gundo.vim'

" fzy stuff
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'jremmen/vim-ripgrep'
Plugin 'kien/ctrlp.vim'
Plugin 'Dkendal/fzy-vim'

" testing
Plugin 'benmills/vimux'
Plugin 'janko-m/vim-test'

" TypeScript server integration
" Plugin 'Quramy/tsuquyomi'

set nocompatible               " be iMproved
filetype off                   " required!

" Ale
let &runtimepath.=',~/.vim/bundle/ale'
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['breakman', 'reek', 'ruby', 'standardrb'],
\   'css': ['stylelint'],
\   'sass': ['stylelint'],
\   'scss': ['stylelint'],
\   'haml': ['hamllint'],
\   'typescript': ['tslint', 'tsserver']
\}
let g:ale_sign_column_always = 1
filetype plugin indent on     " required!
syntax on

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

set tabstop=2
set shiftwidth=2
set expandtab

" Write to swp file ever 250ms.
set updatetime=250

if has("autocmd")
  " set preferred spacing for these filetypes
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType haml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType gitcommit setlocal spell
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

" Force backup copy to true
set backupcopy=yes

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Set tags location
set tags=./tags,tags;

" Custom key maps
let mapleader = ' '

map <Leader>W :FixWhitespace<CR>

" Dispatch stuff
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>

map <Leader>E :Extradite<CR>
map <Leader>B :Gblame<CR>
map <Leader>S :SyntasticCheck<CR>
map <Leader>R :SyntasticReset<CR>

" Copy to RTF
map <Leader>c :CopyRTF<CR>

" Switch to light theme.
map <Leader>p :colorscheme PaperColor \| set background=light \| :ALEToggle<CR>

" vim-test key maps
let test#strategy = "vimux"
let test#ruby#rspec#options = {
  \ 'file': '--format documentation'
\}
nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>n :TestNearest<CR>

" .vimrc editing made easy
nmap <silent> <Leader>c :vs $MYVIMRC<CR>
nmap <silent> <Leader>o :so $MYVIMRC<CR>

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
nnoremap <leader>e :call FzyCommand("rg . -l -g ''", ":e")<cr>
nnoremap <leader>v :call FzyCommand("rg . -l -g ''", ":vs")<cr>
nnoremap <leader>h :call FzyCommand("rg . -l -g ''", ":sp")<cr>
nnoremap <leader>s :call FzyCommand("rg . -l -g ''", ":sp")<cr>
nnoremap <leader>g :call FzyCommand("rg . -l -g '' $(bundle info --path $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy) \| tail -1)", ":vs")<cr>

" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <Leader><Leader>md :!google-chrome-unstable %:p<CR>'

" Setup Ctrl-P search to use ag
if executable("ag")
  set grepprg=ag\
  let g:ctrlp_user_command = 'ag %s -l -g ""'
  let g:ctrlp_use_caching = 0
endif

"RSpec + Dispatch!
let g:rspec_command = 'Dispatch bundle exec rspec {spec}'

"Dispatch compilers
let g:dispatch_compilers = { 'rspec-fast' : 'rspec',
                           \ 'bundle exec': '' }

" JSX syntax highlighting in js files
let g:jsx_ext_required = 0

" Highlight background after 80 chars
let &colorcolumn=join(range(81,999),",")

" Ag search options
let g:ag_prg = 'ag --column'

" @jhawthorn's Co-Authored search - fzy searches git history authors.
command CoAuthor r! echo "Co-authored-by: $(git log --pretty='\%aN <\%aE>' | sort | uniq | fzy)"

 " SG Co-Authors list
command CoAuthorSg r! echo "Co-authored-by: $(cat ~/.coauthors | sort | uniq | fzy)"

" vim: set ft=vim:
