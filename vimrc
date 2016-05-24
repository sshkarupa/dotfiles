set nocompatible

call plug#begin('~/.vim/plugged')

""" plugins list
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Valloric/YouCompleteMe' ", { 'do': 'python3 install.py --clang-completer' }
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'
"Plag 'tomtom/tcomment_vim'

call plug#end()

""" plugins setup
" airline
set laststatus=2
let g:airline_theme='wombat'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_symbols.linenr = '␊ '
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']"

" nerdtree
map <F9> :NERDTreeTabsToggle<CR>

""" vim setup
":colorscheme solarized
colorscheme jellybeans
let g:jellybeans_use_term_background_color = 1

syntax on

set backspace=2 " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50

" Numbers
set number 
set numberwidth=5

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

set t_Co=256

set wildmenu
set wildmode=full 

" Softtabs, 2 spaces
set tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab

"set gfn=Monaco:h10
set guifont=Monaco:h10
set laststatus=2
set cursorline
set autoindent
set ruler
set mousehide
set mouse=a
set ignorecase
set hlsearch

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

set enc=utf-8
set fencs=ucs-bom,utf-8,default,latin1

