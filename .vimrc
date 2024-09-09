" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'             " A Git wrapper so awesome, it should be illegal
Plug 'airblade/vim-gitgutter'         " shows git changes in gutter
Plug 'wincent/Command-T'              " Fast file navigation for VIM
Plug 'scrooloose/nerdtree'            " A tree explorer plugin for vim
Plug 'Lokaltog/vim-easymotion'        " Vim motion on speed
Plug 'vim-airline/vim-airline'        " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " A collection of themes for vim-airline
Plug 'flazz/vim-colorschemes'         " one colorscheme pack to rule them all!
Plug 'sjl/gundo.vim'                  " Vim plugin to visualize your Vim undo tree
Plug 'rking/ag.vim'                   " Vim plugin for the_silver_searcher ag
Plug 'kien/ctrlp.vim'                 " Fuzzy file, buffer, mru, tag, etc finder
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between tmux panes and vim splits
Plug 'tpope/vim-surround'             " surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-commentary'           " comment stuff out
Plug 'Yggdroot/indentLine'            " A vim plugin to display the indention levels with thin vertical lines
Plug 'godlygeek/tabular'              " Vim script for text filtering and alignment
Plug 'junegunn/vim-easy-align'        " A Vim alignment plugin
Plug 'JuliaEditorSupport/julia-vim'   " Vim support for Julia
Plug 'fisadev/vim-isort'              " sort python imports
Plug 'dense-analysis/ale'             " Check syntax in Vim asynchronously and fix files, with LSP support
Plug 'davidhalter/jedi-vim'           " Using the jedi autocompletion library for VIM
Plug '~/my-prototype-plugin'          " Unmanaged plugin (manually installed and updated)

" Initialize plugin system
call plug#end()

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Spaces & Tabs
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=4
set modelines=1
filetype indent on      " load filetype-specific indent files
set autoindent

" UI Config
set number              " show line numbers
set relativenumber      " relative line number
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual auto complete for command menu
"set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
highlight ColorColumn ctermbg=magenta ctermfg=white guibg=#592929
call matchadd('ColorColumn', '\%81v', 100)
" set colorcolumn=80
au BufNewFile,BufRead *.param set filetype=cpp
au BufNewFile,BufRead *.tpp set filetype=cpp
au BufNewFile,BufRead *.kernel set filetype=cpp
au BufNewFile,BufRead *.pf set filetype=fortran

" Searching
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
" nnoremap B ^
nnoremap E $
"" $/^ doesn't do anything
"nnoremap $ <nop>
"nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV `[v`]
set synmaxcol=120

" Leader Shortcuts
let mapleader=","       " leader is comma
"" jk is escape
"inoremap jk <esc>
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" edit vimrc/zshrc/bashrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" save session
"nnoremap <leader>s :mksession<CR>

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" NERDTree
let NERDTreeIgnore = ['\.pyc$', 'build', 'venv', 'egg', 'egg-info/', 'dist','docs']

"" allows cursor change in tmux mode
"if exists('$TMUX')
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
"
" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Vim-LaTeX settings
set shellslash
set grepprg=grep\ -nH\ $*
map <Leader>lx :<C-U>call SetXeTex()<CR>
set iskeyword+=:
let g:tex_conceal = ""

function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction
nnoremap <leader>sp :call FixLastSpellingError()<cr>

" Toggle auto-indenting for code paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Git commit message settings
autocmd Filetype gitcommit setlocal spell textwidth=72

nnoremap <leader>sop :source %<cr>

" Colors
colorscheme badwolf
" colorscheme firewatch
set background=dark              " [dark or light]
syntax enable " enable syntax processing.

" Spell checking settings.
set spell
" No spell checking for idl files.
autocmd BufRead,BufNewFile *.pro setlocal nospell
hi clear SpellBad
hi SpellBad cterm=underline

" Completion
set complete+=kspell

"" Fortran settings
"nmap <S-F> :set syntax=fortran<CR>:let b:fortran_fixed_source=!b:fortran_fixed_source<CR>:set syntax=text<CR>:set syntax=fortran<CR>
"nmap <C-F> :filetype detect<CR>

" Git
autocmd Filetype gitcommit setlocal spell textwidth=72

" Run code in vim
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" Sort python imports
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
let g:vim_isort_map = '<C-i>'

" Format code
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Tabularize
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a; :Tabularize /;\zs<CR>
  vmap <Leader>a; :Tabularize /;\zs<CR>
endif

" gitgutter
let g:gitgutter_async=0
set updatetime=100              " set update time for gitgutter update

" Linting & Fixing
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'c': ['clang'],
      \   'cpp': ['clang', 'g++'],
      \}
let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

" jedi-vim
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" " copy to clipboard
" set clipboard=unnamedplus

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

set backspace=indent,eol,start
