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

" Check for Neovim (:h vim-differences)
if has('nvim')
  let g:vim_dir='~/.config/nvim'
else
  let g:vim_dir='~/.vim'
endif

if filereadable(expand(g:vim_dir . '/autoload/plug.vim'))

call plug#begin(g:vim_dir . '/plugged')

" Editing                                                                   {{{2

" Multiple cursors like Sublime Text
Plug 'terryma/vim-multiple-cursors'

" Quick and basic code alignment
Plug 'junegunn/vim-easy-align'

" Advanced code alignment with regex
Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" Comment out lines
Plug 'tpope/vim-commentary'

" Add and change surrounding quotes or tags
Plug 'tpope/vim-surround'

" Swap the position of two pieces of text
Plug 'tommcdo/vim-exchange'

" Completion                                                                {{{2

" Powerful autocomplete
" Plug 'Valloric/YouCompleteMe', {
"   \ 'do': './install.py --clang-completer',
"   \ 'on': []
"   \ } " :LoadYCM

" Haskell autocomplete
if has('nvim') && has('python3')
  Plug 'Shougo/deoplete.nvim'
endif

" Lightweight non-aggressive auto-pairing
Plug 'rstacruz/vim-closer'

" Magical CSS autocomplete
Plug 'rstacruz/vim-hyperstyle'

" Closes if statements for you
Plug 'tpope/vim-endwise'

" Lightweight autocorrect
Plug 'reedes/vim-litecorrect'

" More aggressive auto-pairing
" Plug 'jiangmiao/auto-pairs'

" Search                                                                    {{{2

" Fuzzy {path, file, buffer} search
Plug 'ctrlpvim/ctrlp.vim'

" Highlight visual selections
Plug 'vasconcelloslf/vim-interestingwords'

" * for visual mode
Plug 'thinca/vim-visualstar'

" Movement and navigation                                                   {{{2
" Emacs-style movement mappings in command mode
Plug 'bruno-/vim-husk'

" Better fold mappings
Plug 'arecarn/fold-cycle.vim'

" Color schemes                                                             {{{2

" Customize your colorscheme's brightness, saturation, contrast, etc.
" Plug 'zefei/vim-colortuner'

" Too many color schemes
Plug 'morhetz/gruvbox'
" Plug 'tomasr/molokai'
" Plug 'junegunn/seoul256.vim'
" Plug 'endel/vim-github-colorscheme'
" Plug 'reedes/vim-colors-pencil'
" Plug 'NLKNguyen/papercolor-theme'
Plug 'w0ng/vim-hybrid'
" Plug 'chriskempson/base16-vim'
" Plug 'joshdick/onedark.vim' | Plug 'joshdick/airline-onedark.vim'
Plug 'ajh17/Spacegray.vim'
" Plug 'altercation/vim-colors-solarized'

" Language and syntax                                                       {{{2

" Syntax mega-pack
Plug 'sheerun/vim-polyglot'

" Better Haskell syntax
if has('nvim')
  Plug 'neovimhaskell/haskell-vim'
else
  Plug 'dag/vim2hs', {'for': 'haskell'}
endif

" MoonScript
Plug 'leafo/moonscript-vim'

" Folded functions show type signatures as labels
Plug 'Twinside/vim-haskellFold'

" JavaScript stuff
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}

" Liquid files for Jekyll
Plug 'tpope/vim-liquid'

" Fish shell config file syntax
Plug 'dag/vim-fish'

" sxhkdrc syntax
Plug 'baskerville/vim-sxhkdrc'

" Screams at you when you have trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Show tags in a sidebar
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

" Mappings and commands                                                     {{{2
" Calculator
Plug 'arecarn/crunch.vim' | Plug 'arecarn/selection.vim'

" So you don't need to leave vim to mkdir, mv, rm, etc.
Plug 'tpope/vim-eunuch'

" Select code based on indent level
Plug 'michaeljsmith/vim-indent-object'

" Better dot repeat with plugin support
Plug 'tpope/vim-repeat'

" Miscellaneous                                                             {{{2

" Syntax and error checking
if has('nvim') || v:version > 704
  Plug 'benekastah/neomake'
endif

" The bar at the bottom
Plug 'bling/vim-airline'

" So you don't need to leave vim to use git
" Plug 'tpope/vim-fugitive'

" Sensible defaults
Plug 'tpope/vim-sensible'

" Better terminal compatibility
Plug 'wincent/terminus'

" Clipboard support for Neovim
if has('neovim')
  Plug 'cazador481/fakeclip.neovim'
endif

" Git uncommitted changes in the gutter
Plug 'airblade/vim-gitgutter'

" Displays marks in the gutter
" Plug 'kshenoy/vim-signature'

" }}}

call plug#end()

" Plugin settings                                                           {{{2
" Tagbar                                                                    {{{3
let g:tagbar_type_haskell={
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

let g:tagbar_type_markdown={
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }

" vim2hs                                                                    {{{3
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

  let g:haskell_hsp=0

" ctrlp                                                                     {{{3
  if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  endif

" airline                                                                   {{{3
  let g:airline_theme='zenburn'
  " let g:airline_theme='onedark'
  let g:airline_powerline_fonts=1
  let g:airline_section_y=''
  let g:airline_extensions=['quickfix', 'whitespace', 'ctrlp']
  " let g:airline#extensions#tagbar#flags='s'

" other                                                                     {{{3
let g:deoplete#enable_at_startup=1
let g:onedark_terminal_italics=1
let g:plug_threads=40
let g:better_whitespace_filetypes_blacklist=[
  \ 'vim-plug',
  \ 'help',
  \ 'gundo',
  \ 'nerdtree'
  \ ]
let g:colortuner_filepath='~/.vim/colortuner'
let g:interestingWordsGUIColors=[
  \ '#99B3FF', '#B399FF', '#E699FF', '#FF99B3',
  \ '#99FFE6', '#FFD65C', '#99FFB3', '#E6FF99',
  \ '#FFB399', '#5CD6FF', '#99FF99', '#FFF6CC'
  \ ]
let g:gitgutter_enabled=0

" }}}

" }}}

else
  echo 'Run :InstallPlugins to install vim-plug'
endif


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

" Enable mouse support
if !has('nvim')
  set mouse+=a
endif

" Stop making bizarre archives
let g:loaded_gzip=1

" Appearance                                                                {{{2

" Enable syntax highlighting
syntax on

" Dark background
set background=dark

" Only highlight 120 columns (performance)
set synmaxcol=120

try
  " Use this if it's installed...
  colorscheme gruvbox
catch
  " ...otherwise fall back to 'darkblue'
  colorscheme darkblue
endtry

" Gutter and statusline                                                     {{{2

" Enable line numbers
set number

" Only show 3 columns for line numbers
set numberwidth=3

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

" Disbale wrapping
set nowrap

" Prefer 80 columns
set textwidth=80

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
set t_vb =

" Buffers and tabs                                                          {{{2

" Allow buffers to be hidden without being closed
set hidden

" Automatically reload files edited outside of Vim
if !has('nvim')
  set autoread
endif

" Automatically cd to the current file's directory
" set autochdir

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

set ttimeout
set ttimeoutlen=10

" }}}


" GUI                                                                       {{{1

if has('gui_running')
  " Highlight the line that the cursor is on
  set cursorline

  let &colorcolumn=join(range(81,120),',')

  set guioptions=eg

  " Use a block cursor everywhere but insert mode
  set guicursor=n-c:block-Cursor-blinkon0,i:ver20

  " Font
  set guifont=PragmataPro:h16

  " Line height
  set linespace=1

  if has('gui_macvim') || has('gui_vimr')
    " Use Option/Alt as the Meta key
    set macmeta
  endif
endif


" FUNCTIONS                                                                 {{{1

if !exists(":InstallPlugins")
function! InstallPlugins()                                                " {{{2
  if filereadable(expand(g:vim_dir . '/autoload/plug.vim'))
    execute 'PlugInstall'
  else
    " Install vim-plug
    execute '!curl -fLo ' . g:vim_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    " Load vim-plug
    execute 'source ' . g:vim_dir . '/autoload/plug.vim'

    " Tell vim-plug about plugins in $MYVIMRC
    execute 'source $MYVIMRC'

    " Install plugins
    execute 'PlugInstall'

    " " Load plugins
    " execute 'source $MYVIMRC'

    " " Close vim-plug split
    " execute 'quit'
  endif
endfunction
endif

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

function! SaddlebackPrint()                                               " {{{2
  " Set up theme
  setlocal background=light
  colorscheme PaperColor

  " Convert to HTML
  execute "TOhtml"

  " Add some JavaScript so the browser prompts to print
  execute "normal! /<body\<CR>f;a window.print();\<Esc>gg"

  " Change to a better font
  execute "normal! /monospace\<CR>iPragmataPro, \<Esc>nniPragmataPro, \<Esc>gg"

  " Disable font ligatures
  execute "normal! /* {\<CR>f}i -webkit-font-variant-ligatures: no-common-ligatures; \<Esc>gg"

  " Decrease font size
  execute "normal! /font-size\<CR>f1a\<BS>0.95\<Esc>gg"

  " " Save the file
  execute "write"

  " " Open in browser
  execute "!open \"%\" -a \"Safari\""

  " " Wait for the browser to load it
  sleep 2

  " " Remove the HTML file
  execute "!rm \"%\""

  " " Close the buffer
  execute "quit!"

  " Close the window
  execute "qa"
endfunction

" }}}


" MAPPINGS                                                                  {{{1

" Unmap                                                                     {{{2
noremap Q       <Nop>
noremap X       <Nop>
noremap M       <Nop>
noremap s       <Nop>
noremap #       <Nop>
noremap &       <Nop>
noremap ,       <Nop>
noremap <C-p>   <Nop>
noremap <Left>  <Nop>
noremap <Down>  <Nop>
noremap <Up>    <Nop>
noremap <Right> <Nop>

" General                                                                   {{{2
noremap  ;     :
noremap  :     ;
noremap  j     gj
noremap  k     gk
noremap  n     nzz
noremap  N     Nzz
noremap  H     ^
noremap  L     g_
noremap  Y     y$
nnoremap J     mzJ`z:delm z<CR>
nnoremap S     mzi<CR><Esc>^gk:silent! s/\v +$//<CR>:noh<CR>`z:delm z<CR>
nnoremap s     :%s/
vnoremap s     :s/
noremap  <BS>  :noh<CR>
nnoremap <CR>  G
noremap  <F1>  <Esc>
vnoremap <     <gv
vnoremap >     >gv
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" Leader                                                                    {{{2
let g:mapleader='\'
map     <Space>   <Leader>
noremap <Leader>t :TagbarToggle<CR>
noremap <Leader>g :GitGutterToggle<CR>

" Homemade vim-unimpaired                                                   {{{2
nnoremap [<Space> mzO<Esc>`z:delm z<CR>
nnoremap ]<Space> mzo<Esc>`z:delm z<CR>
nnoremap [e       "zddk"zP
nnoremap ]e       "zdd"zp
noremap  [b       :bprevious<CR>
noremap  ]b       :bnext<CR>

" Plugin-specific                                                           {{{2
map      <Tab>     <Plug>(fold-cycle-open)
map      <S-Tab>   <Plug>(fold-cycle-close)
vmap     <CR>      <Plug>(EasyAlign)
" Only works in a GUI
noremap  <S-CR>    :Tabularize /

inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ deoplete#mappings#manual_complete()

" }}}


" COMMANDS                                                                  {{{1

" Install vim-plug
command! InstallPlugins call InstallPlugins()

" Edit this file
command! V edit $MYVIMRC

" Change to current directory of file
command! Cd setlocal autochdir | setlocal noautochdir

" Load YouCompleteMe
command! LoadYCM call plug#load('YouCompleteMe') | call youcompleteme#Enable()
                                                \| echo "YouCompleteMe loaded!"

" Open file in Marked 2
command! Marked !open "%" -a "Marked 2"

" Print
command! SaddlebackPrint call SaddlebackPrint()


" AUTOCOMMANDS                                                              {{{1

augroup ForceSettings                                                     " {{{2
  " Reasoning: http://stackoverflow.com/a/8748154
  autocmd!
  if !has('nvim')
    " Vim
    autocmd! BufNewFile,BufRead * setlocal formatoptions=rq2
  else
    " Neovim
    autocmd! BufNewFile,BufRead * setlocal formatoptions=rq2j
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
augroup END

augroup Neomake                                                           " {{{2
  autocmd!
  autocmd BufWritePost * if exists(':Neomake') | Neomake | endif
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

