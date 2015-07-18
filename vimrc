" META {{{1
" vim: foldmethod=marker foldenable synmaxcol=165

" +-------------------------- Made with love by --------------------------+
" | ███████ ██    ██  █████  ███    ██    ██████  ███████ ██      ███████ |
" | ██      ██    ██ ██   ██ ████   ██    ██   ██ ██      ██      ██      |
" | █████   ██    ██ ███████ ██ ██  ██    ██████  █████   ██      █████   |
" | ██       ██  ██  ██   ██ ██  ██ ██    ██   ██ ██      ██      ██      |
" | ███████   ████   ██   ██ ██   ████    ██   ██ ███████ ███████ ██      |
" +----------------- https://github.com/evanrelf/dotfiles ----------------+

"###############################################################################


" PLUGINS {{{1
" Setup {{{
" Check for Neovim {{{
if has('nvim')
  let g:vimFolder='nvim'
else
  let g:vimFolder='vim'
endif " }}}

" Check for vim-plug {{{
if filereadable(expand('~/.' . g:vimFolder . '/autoload/plug.vim'))
  let g:plugged_installed=1
else
  let g:plugged_installed=0
endif " }}}

" Check for fish shell {{{
if &shell=~#'fish$'
  set shell=sh
endif " }}}
" }}}

" Plugins {{{
if g:plugged_installed==1
  call plug#begin('~/.' . g:vimFolder . '/plugged')
  " Considering
  " Plug 'benekastah/neomake'
  " Plug 'vimwiki/vimwiki'

  " Editing
  Plug 'terryma/vim-multiple-cursors'
  Plug 'junegunn/vim-easy-align'
  Plug 'godlygeek/tabular', {'on': 'Tabularize'}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tommcdo/vim-exchange'
  Plug 'Valloric/YouCompleteMe', {
    \ 'do': './install.sh --clang-completer',
    \ 'on': []
    \ } " :LoadYCM
  " Plug 'jiangmiao/auto-pairs'
  Plug 'rstacruz/vim-closer'
  Plug 'tpope/vim-endwise'

  " Search
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'vasconcelloslf/vim-interestingwords'
  Plug 'thinca/vim-visualstar'

  " Movement and navigation
  Plug 'bruno-/vim-husk'
  Plug 'arecarn/fold-cycle.vim'

  " Color schemes
  Plug 'zefei/vim-colortuner'
  Plug 'morhetz/gruvbox'
  Plug 'tomasr/molokai'
  Plug 'junegunn/seoul256.vim'
  Plug 'endel/vim-github-colorscheme'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'w0ng/vim-hybrid'
  Plug 'chriskempson/base16-vim'
  Plug 'altercation/vim-colors-solarized'

  " Language and syntax
  Plug 'sheerun/vim-polyglot'
  Plug 'dag/vim2hs'
  Plug 'Twinside/vim-haskellFold'
  Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'tpope/vim-liquid'
  Plug 'dag/vim-fish'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

  " Mappings and commands
  Plug 'arecarn/crunch.vim' | Plug 'arecarn/selection.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'michaeljsmith/vim-indent-object'

  " Miscellaneous
  Plug 'bling/vim-airline'
  Plug 'tpope/vim-sensible'
  Plug 'wincent/terminus'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  " Plug 'kshenoy/vim-signature'

  call plug#end() " }}}

  " Plugin settings {{{
  if isdirectory(expand('~/.' . g:vimFolder . '/plugged'))
    " Tagbar extra language config {{{
    let g:tagbar_type_haskell = {
      \ 'ctagsbin'  : 'hasktags',
      \ 'ctagsargs' : '-x -c -o-',
      \ 'kinds'     : [
        \ 'm:modules:0:1',
        \ 'd:data: 0:1',
        \ 'd_gadt: data gadt:0:1',
        \ 't:type names:0:1',
        \ 'nt:new types:0:1',
        \ 'c:classes:0:1',
        \ 'cons:constructors:1:1',
        \ 'c_gadt:constructor gadt:1:1',
        \ 'c_a:constructor accessors:1:1',
        \ 'ft:function types:1:1',
        \ 'fi:function implementations:0:1',
        \ 'o:others:0:1'
      \ ],
      \ 'sro'        : '.',
      \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
      \ },
      \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
      \ }
    \ }

    let g:tagbar_type_markdown = {
      \ 'ctagstype' : 'markdown',
      \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
      \ ]
    \ } " }}}
    " vim2hs {{{
      let g:haskell_tabular=0
      let g:haskell_conceal=0
      let g:haskell_conceal_enumerations=0

      " Quasiquoting
      let g:haskell_quasi=0
      let g:haskell_interpolation=0
      let g:haskell_regex=0
      let g:haskell_jmacro=0
      let g:haskell_shqq=0
      let g:haskell_sql=0
      let g:haskell_json=0
      let g:haskell_xml=0

      let g:haskell_hsp = 0
    " }}}
    let g:plug_threads=40
    let g:better_whitespace_filetypes_blacklist=[
      \ 'vim-plug',
      \ 'help',
      \ 'gundo',
      \ 'nerdtree'
      \ ]
    let g:airline_theme='zenburn'
    let g:airline_powerline_fonts=1
    let g:airline_extensions=['whitespace', 'hunks', 'ctrlp']
    let g:ctrlp_map=''
    let g:colortuner_filepath='~/.vim/colortuner'
    let g:interestingWordsGUIColors=[
      \ '#99B3FF', '#B399FF', '#E699FF', '#FF99B3',
      \ '#99FFE6', '#FFD65C', '#99FFB3', '#E6FF99',
      \ '#FFB399', '#5CD6FF', '#99FF99', '#FFF6CC'
      \ ]
  endif
else
  if !&secure
    echo "\nRun ':Install' to install plugins\n"

    if g:vimFolder == 'nvim' && isdirectory(expand('~/.vim/plugged'))
      echo "It looks like you already have some plugins installed for regular"
      echo "Vim. If you don't want redundant plugins, you should symlink `~/.vim`"
      echo "to `~/.nvim`.\n"
    endif
  endif
endif " }}}

"###############################################################################


" SETTINGS {{{1
" General {{{
filetype plugin indent on
set backspace=indent,eol,start
set virtualedit=block
set mouse+=a
let loaded_gzip=1 " Stop making weird `X~=@l9q5` files
" }}}

" Syntax highlighting and color schemes {{{
syntax on
set synmaxcol=120
set background=dark
try
  colorscheme gruvbox
catch
  colorscheme darkblue
endtry
" }}}

" Gutter and statusline {{{
set number
set numberwidth=3
set laststatus=2
set showcmd
set noshowmode
set ruler
" }}}

" Command mode {{{
set history=1000
set wildmenu
set wildmode=longest,list
set wildignore+=*/tmp/*,*.so,*.swp,*.bak,*.o,*.hi
set wildignore+=*.zip,*.map,*.pdf
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd,*.tiff
set wildignore+=.git,.hs,.svn
" }}}

" Indentation and tabs {{{
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
" }}}

" Search {{{
set hlsearch
set incsearch
set gdefault
set ignorecase
set smartcase
" }}}

" Swap/backup/undo files {{{
set noswapfile
set nobackup
set noundofile
" }}}

" Splits {{{
set splitright
set splitbelow
" }}}

" Scrolling and wrapping {{{
set scrolloff=2
set sidescroll=1
set sidescrolloff=7
set nowrap
set textwidth=80
" }}}

" Folding {{{
set nofoldenable
set foldmethod=indent
set foldnestmax=4
" }}}

" Bells {{{
set noerrorbells
set visualbell
set t_vb=
" }}}

" Buffers and tabs {{{
set hidden
set autoread
set autochdir
set switchbuf=usetab
set title
let &titleold=getcwd()
" }}}

" Performance {{{
set ttyfast
set lazyredraw
set ttimeout
set ttimeoutlen=10
" }}}

"###############################################################################


" GUI {{{1
if has('gui_running')
  " GUI
  set cursorline
  let &colorcolumn=join(range(81,120),',')
  set guioptions=egt
  set guicursor=n-c:block-Cursor-blinkon0,i:ver20
  set guifont=Pragmata\ Pro:h16

  if has('gui_macvim') || has('gui_vimr')
    set macmeta
  endif
endif

"###############################################################################


" FUNCTIONS {{{1
function! Bootstrap() " {{{
  if g:plugged_installed==1
    echomsg 'Plugins already installed!'
  else
    silent! execute '!curl -fLo ~/.' . g:vimFolder . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    silent! execute 'source ~/.' . g:vimFolder . '/autoload/plug.vim'
    silent! execute 'source $MYVIMRC'
    execute 'PlugInstall'
    echomsg 'Restart to load plugins'
  endif
endfunction " }}}

function! Markdown() " {{{
  setlocal filetype=markdown
  setlocal wrap
  setlocal linebreak
  setlocal spell
  let g:markdown_fenced_languages=[
    \ 'coffee', 'css', 'erb=eruby', 'javascript',
    \ 'js=javascript', 'json=javascript', 'ruby',
    \ 'sass', 'xml', 'html'
    \ ]
endfunction " }}}

function! CPP() " {{{
  if has('gui_running')
    " Saddleback
    let &colorcolumn=join(range(76,80),',')
    setlocal textwidth=75
  endif
endfunction " }}}

function! CustomFoldText() " {{{
  " http://dhruvasagar.com/2013/03/28/vim-better-foldtext
  " http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/

  " The characters used in single-line comments -------> [       here       ]   and    [       here       ]
  let line=' ' . substitute(getline(v:foldstart), '^\s*["#(//)(--)(;{1-2})]\?\s*\|\s*["#(//)(--)(;{1-2})]\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count=v:foldend - v:foldstart + 1
  let foldpercentage=printf("[%.0f", ((1+v:foldend-v:foldstart)*1.0)/(line("$"))*100) . "%] "
  let foldchar=matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart=strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend=' ' . (1 + v:foldend - v:foldstart) . ' lines ' . repeat(foldchar, 8)
  let foldtextlength=strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=CustomFoldText() " }}}

"###############################################################################


" MAPPINGS {{{1

" Unmap {{{
noremap Q <Nop>
noremap K <Nop>
noremap X <Nop>
noremap M <Nop>
noremap s <Nop>
noremap # <Nop>
noremap & <Nop>
noremap , <Nop>
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
" }}}

" General {{{
noremap ; :
noremap : ;
noremap j gj
noremap k gk
noremap n nzz
noremap N Nzz
noremap H ^
noremap L g_
noremap Y y$
nnoremap J mzJ`z:delm z<CR>
nnoremap S mzi<CR><Esc>^gk:silent! s/\v +$//<CR>:noh<CR>`z:delm z<CR>
nnoremap s :%s/\v
vnoremap s :s/\v
noremap <BS> :noh<CR>
noremap <F1> <Esc>
vnoremap < <gv
vnoremap > >gv
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" Leader
let g:mapleader='\'
map <Space> <Leader>
noremap <Leader>t :TagbarToggle<CR>

" Homemade vim-unimpaired
nnoremap [<Space> mzO<Esc>`z:delm z<CR>
nnoremap ]<Space> mzo<Esc>`z:delm z<CR>
nnoremap [e "zddk"zP
nnoremap ]e "zdd"zp
noremap [b :bprevious<CR>
noremap ]b :bnext<CR>
" }}}

" Plugin-specific {{{
if g:plugged_installed==1
  map <Tab> <Plug>(fold-cycle-open)
  map <S-Tab> <Plug>(fold-cycle-close)

  vmap <Enter> <Plug>(EasyAlign)
  noremap <S-Enter> :Tabularize /

  noremap <Leader>p :CtrlPMixed<CR>
endif
" }}}

"###############################################################################


" MACROS {{{1
" Convert Atom package name to Markdown link
" (e.g. '* foobar' -> '* [foobar](https://atom.io/packages/foobar)')
" noremap <Leader>pk g_a(http://atom.io/packages/)^f lvt(yg_hpgva]F a[j

"###############################################################################


" COMMANDS {{{1
command! Install call Bootstrap()
command! V edit $MYVIMRC
command! LoadYCM call plug#load('YouCompleteMe') | call youcompleteme#Enable() | echo "YouCompleteMe loaded!"
command! Marked !open % -a "Marked 2"

"###############################################################################


" AUTOCOMMANDS {{{1
augroup ForceSettings " {{{
  " Reasoning: http://stackoverflow.com/a/8748154
  autocmd!
  autocmd! BufNewFile,BufRead * setlocal formatoptions=crq2j
augroup END " }}}

augroup FileTypeAware " {{{
  autocmd!
  autocmd FileType vim setlocal keywordprg=':help'
  autocmd BufRead,BufNewFile *.md call Markdown()
  autocmd FileType cpp call CPP()
  autocmd FileType gitcommit setlocal spell textwidth=72
  autocmd FileType vim-plug setlocal nonumber
augroup END " }}}

" augroup InsertMode " {{{
"   autocmd!
"   autocmd InsertLeave * set nopaste
" augroup END " }}}

"###############################################################################


" COPY-PASTED {{{1

" Clear all registers {{{
" (otherwise they are preserved between sessions)
" http://stackoverflow.com/a/19431165
command! ClearReg let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"' | let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | let i=i+1 | endwhile | unlet regs
" }}}

" Source operator - gs {{{
" https://github.com/saaguero/vim-utils/blob/master/plugin/utils.vim#L1-L28
function! SourceVimscript(type)
  let sel_save=&selection
  let &selection='inclusive'
  let reg_save=@"

  if a:type=='line'
    silent execute "normal! '[V']y"
  elseif a:type=='char'
    silent execute "normal! `[v`]y"
  elseif a:type=="visual"
    silent execute "normal! gvy"
  elseif a:type=="currentline"
    silent execute "normal! yy"
  endif

  let @"=substitute(@", '\n\s*\\', '', 'g')

  @" " source the content

  let &selection=sel_save
  let @"=reg_save
endfunction

nnoremap <silent> gs :set opfunc=SourceVimscript<CR>g@
vnoremap <silent> gs :<C-U>call SourceVimscript("visual")<CR>
nnoremap <silent> gss :call SourceVimscript("currentline")<CR>
" }}}

"###############################################################################


