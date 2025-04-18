set nocompatible               " be iMproved
filetype off                   " required!
set encoding=utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" tpope is the man
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
" extension to fugitive
Plug 'int3/vim-extradite'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" more mvment
Plug 'bkad/CamelCaseMotion'
Plug 'terryma/vim-multiple-cursors'

" make preetty
Plug 'nanotech/jellybeans.vim'
Plug 'rking/vim-detailed'
Plug 'NLKNguyen/papercolor-theme'

" linting
Plug 'dense-analysis/ale'

" syntax highlighting
Plug 'kchmck/vim-coffee-script'
Plug 'briancollins/vim-jst'
Plug 'yaymukund/vim-rabl'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cakebaker/scss-syntax.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elixir-lang/vim-elixir'
Plug 'leafgarland/typescript-vim'
if has('macunix')
  Plug 'zerowidth/vim-copy-as-rtf'
endif
Plug 'kyoh86/vim-jsonl'
Plug 'jparise/vim-graphql'

Plug 'bronson/vim-trailing-whitespace'
Plug 'sjl/gundo.vim'

" fzy stuff
Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'kien/ctrlp.vim'
Plug 'Dkendal/fzy-vim'

" testing
Plug 'thoughtbot/vim-rspec'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'

" Pass focus events to vim from tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Github Copilot
Plug 'github/copilot.vim'

" TypeScript server integration
" Plug 'Quramy/tsuquyomi'

call plug#end()

" Ale
let &runtimepath.=',~/.vim/bundle/ale'
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['breakman', 'ruby', 'standardrb'],
\   'css': ['stylelint'],
\   'sass': ['stylelint'],
\   'scss': ['stylelint'],
\   'haml': ['hamllint'],
\   'typescript': ['tslint', 'tsserver']
\}
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 'disabled'
syntax on

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

set tabstop=2
set shiftwidth=2
set expandtab

" Write to swp file ever 250ms.
set updatetime=250

" Refresh buffer when it changes on disk. Only unchanged buffers will be
" affected.
set autoread

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

" Switch to light theme and disable ALE (presentation mode).
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

" Setup Ctrl-P search to use rg
if executable("rg")
  set grepprg=rg\
  let g:ctrlp_user_command = 'rg %s -l -g ""'
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

" netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
" augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
" augroup END

" @jhawthorn's Co-Authored search - fzy searches git history authors.
command CoAuthor r! echo "Co-authored-by: $(git log --pretty='\%aN <\%aE>' | sort | uniq | fzy)"

command CoCoAuthor r! echo "Co-authored-by: $(git log --grep 'Co-authored-by:' | awk -F: '/Co-authored-by:/ {print $2}' | sort | uniq | fzy)"

 " SG Co-Authors list
command CoAuthorSg r! echo "Co-authored-by: $(cat ~/.coauthors | sort | uniq | fzy)"

" vim: set ft=vim:
