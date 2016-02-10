" META                                                                      {{{1
" Best viewed in Vim (for the folds)
" vim: foldmethod=marker foldenable synmaxcol=165
"
" ,-----------------------------------------------------------------------,
" | ███████ ██    ██  █████  ███    ██    ██████  ███████ ██      ███████ |
" | ██      ██    ██ ██   ██ ████   ██    ██   ██ ██      ██      ██      |
" | █████   ██    ██ ███████ ██ ██  ██    ██████  █████   ██      █████   |
" | ██       ██  ██  ██   ██ ██  ██ ██    ██   ██ ██      ██      ██      |
" | ███████   ████   ██   ██ ██   ████    ██   ██ ███████ ███████ ██      |
" `----------------< https://github.com/evanrelf/dotfiles >---------------'


" PLUGINS                                                                   {{{1
call plug#begin('~/.config/nvim/plugged')

" Editing                                                                   {{{2

" Multiple cursors like Sublime Text
Plug 'terryma/vim-multiple-cursors'
" Simple code alignment
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
" Advanced code alignment with regex
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
" Comment out lines
Plug 'tpope/vim-commentary'
" Add and change surrounding quotes or tags
Plug 'tpope/vim-surround'

" Completion                                                                {{{2

" if has('nvim')
"   " Async autocomplete
"   " FIXME: Conflicts with `lexima.vim`
"   " Plug 'Shougo/deoplete.nvim'
" else
"   " Lightweight completion
"   Plug 'ajh17/VimCompletesMe'
" endif

" Lightweight completion
Plug 'ajh17/VimCompletesMe'
" Auto-pairing of parens and quotes
Plug 'cohama/lexima.vim'
" Closes blocks for you
Plug 'tpope/vim-endwise'
" Magical CSS autocomplete
Plug 'rstacruz/vim-hyperstyle', {'for': ['css', 'less', 'sass', 'stylus']}

" Search                                                                    {{{2

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
" Search content of files
Plug 'rking/ag.vim', {'on': 'Ag'}

" Movement and navigation                                                   {{{2

" Better fold mappings
Plug 'arecarn/fold-cycle.vim'

" Color schemes                                                             {{{2

" Futher customize color schemes
" Plug 'zefei/vim-colortuner'

Plug 'morhetz/gruvbox'
" Plug 'junegunn/seoul256.vim'
" Plug 'tomasr/molokai'
" Plug 'endel/vim-github-colorscheme'
" Plug 'reedes/vim-colors-pencil'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'w0ng/vim-hybrid'
" Plug 'chriskempson/base16-vim'
" Plug 'joshdick/onedark.vim' | Plug 'joshdick/airline-onedark.vim'
" Plug 'ajh17/Spacegray.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'AlessandroYorba/Alduin'

" Language and syntax                                                       {{{2

" Syntax mega-pack
Plug 'sheerun/vim-polyglot'
" Folded functions show type signatures as labels
Plug 'Twinside/vim-haskellFold'
" Fish shell config file syntax
Plug 'dag/vim-fish'
" sxhkdrc syntax
Plug 'baskerville/vim-sxhkdrc'
" Syntax checking
Plug 'scrooloose/syntastic'
" Highlights trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Mappings and commands                                                     {{{2

" So you don't need to leave vim to mkdir, mv, rm, etc.
Plug 'tpope/vim-eunuch'
" Better dot repeat with plugin support
Plug 'tpope/vim-repeat'
" Convenience mappings
Plug 'tpope/vim-unimpaired'

" Interface                                                                 {{{2

" The bar at the bottom
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Show buffers in vim-airline
Plug 'bling/vim-bufferline'
" Flash yanked area
Plug 'haya14busa/vim-operator-flashy' | Plug 'kana/vim-operator-user'

" Miscellaneous                                                             {{{2

" Better terminal compatibility
Plug 'wincent/terminus'
" Automatic `:set paste`
Plug 'ConradIrwin/vim-bracketed-paste'
if has('nvim')
  " Clipboard support for Neovim
  Plug 'cazador481/fakeclip.neovim'
endif

" }}}

call plug#end()

" Plugin settings                                                           {{{2
let g:lexima_enable_endwise_rules=0
let g:deoplete#enable_at_startup=1
let g:operator#flashy#flash_time=150
let g:bufferline_echo=0
let g:bufferline_show_bufnr=0
let g:plug_threads=40
let g:airline_theme='zenburn'
let g:airline_powerline_fonts=1
let g:airline_section_y=''
let g:airline_extensions=[
  \ 'quickfix',
  \ 'whitespace',
  \ 'ctrlp',
  \ 'syntastic',
  \ 'bufferline'
  \ ] " unite
let g:better_whitespace_filetypes_blacklist=[
  \ 'vim-plug',
  \ 'help',
  \ 'gundo',
  \ 'nerdtree',
  \ 'unite'
  \ ]
let g:ctrlp_extensions=[
  \ 'line',
  \ 'dir',
  \ 'yankring'
  \ ]
" }}}


" SETTINGS                                                                  {{{1

" General                                                                   {{{2

" Enable stuff
filetype plugin indent on

" Make backspace work normally
if !has('nvim')
  set backspace=indent,eol,start
endif

" Let virtual block mode extend beyond EOL
set virtualedit=block

" Stop making bizarre archives
let g:loaded_gzip=1

" Appearance                                                                {{{2

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Dark background
set background=dark

" Only highlight 120 columns (performance)
set synmaxcol=120

" Fallback color scheme
try
  " let g:seoul256_background=236
  colorscheme gruvbox
catch
  colorscheme darkblue
endtry

" Gutter and statusline                                                     {{{2

" Enable line numbers
set number

" Only show 3 columns for line numbers
set numberwidth=4

" Show statusbar
if !has('nvim')
  set laststatus=2
endif

" Show command in statusbar
set showcmd

" Don't show mode in statusbar (because vim-airline replaces this)
set noshowmode

" Show line and column in statusbar
set ruler

" Command mode                                                              {{{2

" Remeber all my commands
if !has('nvim')
  set history=10000
endif

" Use wildmenu suggestions
if !has('nvim')
  set wildmenu
endif
set wildmode=longest,list

" Ignore these files in the wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.bak,*.o,*.hi
set wildignore+=*.zip,*.map,*.pdf
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd,*.tiff
set wildignore+=.git,.hs,.svn

" Indentation and tabs                                                      {{{2

" Use spaces instead of tabs
set expandtab
if !has('nvim')
  set smarttab
endif

" Two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Intelligent indentation
if !has('nvim')
  set autoindent
endif
set smartindent

" Search                                                                    {{{2

" Highlight search result
if !has('nvim')
  set hlsearch
endif

" Highlight search as it's typed
if !has('nvim')
  set incsearch
endif

" Global by defaultl
set gdefault

" Case-insensitive...
set ignorecase

" ...unless you use capital letters
set smartcase

" Swap/backup/undo files                                                    {{{2

" Disable swap files
set noswapfile

" Disable backups
set nobackup

" Disable undo files
set noundofile

" Splits                                                                    {{{2

" Splits open to the right
set splitright

" Splits open below
set splitbelow

" Scrolling and wrapping                                                    {{{2

" Padding at top and bottom edges
set scrolloff=2

" How many columns to scroll sideways
set sidescroll=1

" Padding at top and bottom edges
set sidescrolloff=7

" Enable wrapping
set wrap

" Folding                                                                   {{{2

" Disable folding
set nofoldenable

" Use indentation for folding
set foldmethod=indent

" Maximum foldception
set foldnestmax=4

" Bells                                                                     {{{2

" Disable error bell
set noerrorbells

" Enable visual bell
set visualbell

" Disable visual bell
set t_vb=

" Buffers and tabs                                                          {{{2

" Allow buffers to be hidden without being closed
set hidden

" Automatically reload files edited outside of Vim
if !has('nvim')
  set autoread
endif

" Switch to the first open window or tab that contains the specified buffer
set switchbuf=usetab

" Set title of the terminal window
set title

" Disable 'Thanks for flying Vim'
let &titleold=getcwd()

" Performance                                                               {{{2

" Indicate a fast terminal connection
if !has('nvim')
  set ttyfast
endif

" Don't redraw the screen when executing long macros and stuff
set lazyredraw

" Delay for mappings
set timeoutlen=1000

" Delay for keycode sequences
set ttimeoutlen=10

set ttimeout

" }}}


" GUI                                                                       {{{1

if has('gui_running')
  " Highlight columns past 80
  let &colorcolumn=join(range(81,120),',')

  set guioptions=eg

  " Use a block cursor everywhere but insert mode
  set guicursor=n-c:block-Cursor-blinkon0,i:ver20

  " Font
  set guifont=PragmataPro:h16

  " Line height
  set linespace=1
endif


" FUNCTIONS                                                                 {{{1

function! CustomFoldText()                                                " {{{2
  " http://dhruvasagar.com/2013/03/28/vim-better-foldtext
  " http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/

  " The characters used in single-line comments -----> [       here       ]   and    [       here       ]
  let line=' ' . substitute(getline(v:foldstart), '^\s*["#(//)(\-\-)(;{1-3})]\?\s*\|\s*["#(//)(\-)(;{1-3})]\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count=v:foldend - v:foldstart + 1
  let foldpercentage=printf("[%.0f", ((1+v:foldend-v:foldstart)*1.0)/(line("$"))*100) . "%] "
  let foldchar=matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart=strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend=' ' . (1 + v:foldend - v:foldstart) . ' lines ' . repeat(foldchar, 8)
  let foldtextlength=strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=CustomFoldText()

function! Markdown()                                                      " {{{2
  setlocal filetype=markdown
  " setlocal wrap
  " setlocal linebreak
  " setlocal spell
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
  let g:markdown_fenced_languages=[
    \ 'coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript',
    \ 'json=javascript', 'ruby', 'sass', 'xml', 'html'
    \ ]
endfunction

function! CPP()                                                           " {{{2
  " Saddleback style
  setlocal textwidth=75

  if has('gui_running')
    let &colorcolumn=join(range(76,80),',')
  endif
endfunction

function! Unite() " {{{2
  nmap <buffer> <Esc>   <Plug>(unite_exit)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <buffer> <Tab>   <Plug>(unite_select_next_line)
  imap <buffer> <S-Tab> <Plug>(unite_select_previous_line)
endfunction
" }}}


" MAPPINGS                                                                  {{{1

" Unmap                                                                     {{{2
noremap Q       <Nop>
noremap X       <Nop>
noremap M       <Nop>
noremap #       <Nop>
noremap &       <Nop>
noremap ,       <Nop>
noremap <Left>  <Nop>
noremap <Down>  <Nop>
noremap <Up>    <Nop>
noremap <Right> <Nop>

" General                                                                   {{{2
noremap  ;     :
noremap  :     ;
noremap  j     gj
noremap  k     gk
" noremap  n     nzz
" noremap  N     Nzz
noremap  H     ^
noremap  L     g_
noremap  Y     y$
nnoremap J     mzJ`z:delm z<CR>
" nnoremap S     mzi<CR><Esc>^gk:silent! s/\v +$//<CR>:noh<CR>`z:delm z<CR>
noremap  <BS>  :noh<CR>
noremap  <F1>  <Esc>
vnoremap <     <gv
vnoremap >     >gv
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" Leader                                                                    {{{2
let g:mapleader='\'
map <Space> <Leader>

" Unite {{{
" noremap <Leader>u/ :Unite -no-split -auto-preview -vertical-preview -start-insert line<CR>
" noremap <Leader>u- :Unite -direction=dynamicbottom -start-insert file<CR>
" noremap <Leader>ub :Unite -direction=dynamicbottom -quick-match buffer<CR>
" noremap <Leader>uy :Unite -direction=dynamicbottom -quick-match history/yank<CR>
" }}}
" CtrlP {{{
noremap <Leader>/ :CtrlPLine<CR>
noremap <Leader>f :CtrlP<CR>
noremap <Leader>b :CtrlPBuffer<CR>
noremap <Leader>y :CtrlPYankring<CR>
" }}}
" Splits {{{
" Create
noremap <Leader>wt :vsplit +terminal<CR>
" Move
noremap <Leader>wh <C-w>h
noremap <Leader>wj <C-w>j
noremap <Leader>wk <C-w>k
noremap <Leader>wl <C-w>l
" Close
noremap <Leader>wc <C-w>c
" }}}
" Alignment {{{
noremap <Leader>ae :EasyAlign<CR>
noremap <Leader>at :Tabularize /
" }}}
" Substitute {{{
nnoremap <Leader>s :%s/
vnoremap <Leader>s :s/
" }}}

" Plugin-specific                                                           {{{2
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

nmap <Tab>   <Plug>(fold-cycle-open)
nmap <S-Tab> <Plug>(fold-cycle-close)

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" }}}


" COMMANDS                                                                  {{{1

" Edit this file
command! V edit $MYVIMRC

" Change to current directory of file
command! Cd setlocal autochdir | setlocal noautochdir


" AUTOCOMMANDS                                                              {{{1

augroup ForceSettings                                                     " {{{2
  " Reasoning: http://stackoverflow.com/a/8748154
  autocmd!
  if has('nvim')
    autocmd! BufNewFile,BufRead * setlocal formatoptions=rq2j
  else
    autocmd! BufNewFile,BufRead * setlocal formatoptions=rq2
  endif
augroup END

augroup FileTypeAware                                                     " {{{2
  autocmd!
  autocmd FileType vim setlocal keywordprg=:help
  autocmd BufRead,BufNewFile *.md call Markdown()
  autocmd BufRead,BufNewFile *.plist setlocal filetype=xml
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType cpp call CPP()
  autocmd FileType gitcommit setlocal spell linebreak textwidth=72
  autocmd FileType vim-plug setlocal nonumber
  autocmd FileType unite call Unite()
augroup END
" }}}


" COPY-PASTED                                                               {{{1

" Clear all registers                                                       {{{2
" (otherwise they are preserved between sessions)
" http://stackoverflow.com/a/19431165

command! ClearReg
  \ let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
  \| let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | let i=i+1
  \| endwhile | unlet regs | echo 'Registers cleared!'

" Source operator - gs                                                      {{{2
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


