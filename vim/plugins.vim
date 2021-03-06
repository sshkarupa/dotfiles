" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Color theme
Plug 'nanotech/jellybeans.vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Gitter
Plug 'airblade/vim-gitgutter'

" Automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'

" NERDtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Search with Ag
Plug 'rking/ag.vim'

" Ctrl-P
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'

Plug 'tpope/vim-rails'

Plug 'tpope/vim-surround'

" Awesome Git wrapper
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/syntastic'

" The Vim RuboCop plugin runs RuboCop and displays the results in Vim
Plug 'ngmy/vim-rubocop'

" UltiSnips - The ultimate snippet solution for Vim.
Plug 'SirVer/ultisnips'

" Vim configuration files for Elixir http://elixir-lang.org/
" Plug 'elixir-lang/vim-elixir'
Plug 'elixir-editors/vim-elixir'

" Vastly improved Javascript indentation and syntax support in Vim
Plug 'pangloss/vim-javascript'

" React JSX syntax highlighting and indenting for vim
Plug 'mxw/vim-jsx'

" nginx conf highlighting
Plug 'chr4/nginx.vim'

" Support hashicorp/hcl format
Plug 'fatih/vim-hclfmt'

" Support toml format
Plug 'cespare/vim-toml'

" Initialize plugin system
call plug#end()

"
" PLUGINS SETTINGS ============================

" Custom Highlights
let g:jellybeans_overrides = {
\  'rubyRegexpDelimiter': { 'guifg': 'de5577' },
\  'rubyRegexp': { 'guifg': 'de5577' },
\  'rubyRegexpSpecial': { 'guifg': 'de5577' }
\}
"
" Ag --------------------------------------------
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  " sets the right grepformat.
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  " bind K to grep word under cursor
  nnoremap K :silent! grep! "\b<C-r><C-w>\b"<CR>:cwindow<CR>:redraw!<CR>
  " bind \ to :Ag
  nnoremap \ :Ag<Space>
  " adds :Ag ???
  command! -nargs=+ -complete=file_in_path -bar Ag silent grep! <args>|cwindow|redraw!
endif

" airline ---------------------------------------
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

" Ctrl-P: fuzzyfinder for Vim--------------------
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']"

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$|bower_components|node_modules',
      \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
      \ }

" CtrlP auto cache clearing
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

" nerdcommenter ---------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

" map <C-/> to toggle comments (only for vim)
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" NERDtree --------------------------------------
" <F9> | NERD Tree
nnoremap <F9> :NERDTreeToggle<CR>
" :NERDTreeMirror<CR>

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>")) | wincmd p

autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

" emmet-vim -------------------------------------
let g:user_emmet_mode='a'
let g:user_emmet_install_global = 0
autocmd FileType html,css,sass,scss,slim,erb EmmetInstall
autocmd FileType html,css,sass,scss,slim,erb imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Syntastic --------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'yarn run lint --'

let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
nnoremap <F6> :SyntasticCheck<CR> :lopen<CR>

" Vim-rubocop -----------------------------------
let g:vimrubocop_config = '~/.vim/rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

" Vim-markdown ----------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

" Tagbar ----------------------------------------
" nmap <F8> :TagbarToggle<CR>

" Surround --------------------------------------
" ,# surround a word with #{ruby interpolation}
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>

" ," surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

map ,` ysiw`

" }}

" end -------------------------------------------

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger       ='<tab>'
let g:UltiSnipsJumpForwardTrigger  ='<tab>'
let g:UltiSnipsJumpBackwardTrigger ='<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" vim-javascript --------------------------------
let g:javascript_plugin_flow = 1
set foldmethod=syntax

" vim-jsx ---------------------------------------
let g:jsx_ext_required = 0
" let g:jsx_pragma_required = 1

" vim-hclfmt ------------------------------------
let g:hcl_fmt_autosave = 0
let g:tf_fmt_autosave = 0
let g:nomad_fmt_autosave = 0
