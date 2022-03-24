"No compatibility to traditional vi
set nocompatible

"vim-plug
call plug#begin('~/.config/nvim/plugged')

"Plugin list ------------------------------------------------------------------

Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/Mustang2'
Plug 'vim-scripts/darktango.vim'
Plug 'junegunn/seoul256.vim'
Plug 'vim-scripts/xoria256.vim'
Plug 'jdkanani/vim-material-theme'
Plug 'rakr/vim-one'

Plug 'neovimhaskell/haskell-vim'
Plug 'godlygeek/tabular'
Plug 'achimnol/python-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'lepture/vim-jinja'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'pdurbin/vim-tsv'
Plug 'PProvost/vim-ps1'

Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'simnalamburt/vim-mundo'
Plug 'rhysd/committia.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'junegunn/vim-slash'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'wellle/context.vim'
Plug 'sgur/vim-editorconfig'

if !has("win32")
  Plug 'wakatime/vim-wakatime'
endif

"End plugin list --------------------------------------------------------------
call plug#end()

if has("macunix")
  language en_US
else
  language en_US.utf8
endif

"Syntax highlighting.
syntax on

"Softtab -- use spaces instead tabs.
set expandtab
set tabstop=4 shiftwidth=4 sts=4
set autoindent nosmartindent

"set tab characters apart
set listchars=tab:↹\

"I dislike CRLF.
if !exists("vimpager")
  set fileformat=unix
endif

set backspace=2

"Detect modeline hints.
set modeline

"Disable bell
set visualbell t_vb=

"Prefer UTF-8.
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp949,korea,iso-2022-kr

"More tabs
set tabpagemax=25

filetype plugin on

"Some additional syntax highlighters.
au! BufRead,BufNewFile *.sass setfiletype sass
au! BufRead,BufNewFile *.scss setfiletype scss
au! BufRead,BufNewFile *.haml setfiletype haml
au! BufRead,BufNewFile *.less setfiletype less

"These languages have their own tab/indent settings.
au FileType cpp    setl ts=2 sw=2 sts=2
au FileType ruby   setl ts=2 sw=2 sts=2
au FileType yaml   setl ts=2 sw=2 sts=2
au FileType html   setl ts=2 sw=2 sts=2
au FileType jinja  setl ts=2 sw=2 sts=2
au FileType haml   setl ts=2 sw=2 sts=2
au FileType sass   setl ts=2 sw=2 sts=2
au FileType scss   setl ts=2 sw=2 sts=2
au FileType make   setl ts=4 sw=4 sts=4 noet
au FileType rst    setl spell
au FileType gitcommit setl spell

"ALE-related configurations.
let g:ale_linters = {
\   'haskell': ['stack-ghc-mod', 'hlint'],
\   'rust': ['cargo'],
\   'typescript': ['deno'],
\}
let b:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['prettier'],
\   'typescript': ['deno'],
\}
let g:ale_fix_on_save = 1
let g:ale_deno_unstable = 1
nmap gr :ALERename
nmap gR :ALEFindReferences
nmap gd :ALEGoToDefinition
nmap gD :ALEGoToTypeDefinition
nmap <silent> <C-]> :ALEGoToDefinition
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"Python-related configurations.
"See also: https://github.com/achimnol/python-syntax#options-used-by-the-script
let python_highlight_builtins = 1
let python_highlight_type_annotations = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 0
let python_highlight_indent_errors = 1
let python_highlight_space_errors = 0
let python_highlight_doctests = 1

"Markdown-related configurations.
augroup mkd
  autocmd BufRead *.markdown set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkdn     set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkd      set formatoptions=tcroqn2 comments=n:> spell
augroup END

"Haskell-related config
let g:haskell_quasi         = 0
let g:haskell_interpolation = 0
let g:haskell_regex         = 0
let g:haskell_jmacro        = 0
let g:haskell_shqq          = 0
let g:haskell_sql           = 0
let g:haskell_json          = 0
let g:haskell_xml           = 0
let g:haskell_hsp           = 0

"English spelling checker.
setlocal spelllang=en_us

"Keep 80 columns.
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
autocmd WinEnter * match OverLength /\%81v.\+/

"I dislike folding.
set nofoldenable

"I dislike visual bell as well.
set novisualbell

"vim-airline
let g:airline_powerline_fonts = 1

"Mundo -- Undo tree visualization
set undofile
set undodir=~/.config/nvim/undo
nnoremap <F5> :MundoToggle

"deoplete
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

"True colors
if $TERM_PROGRAM == "iTerm.app" || has("gui_vimr")
  set termguicolors
  colorscheme material-theme
  set background=dark
else
  colorscheme seoul256
  set background=dark
endif

"Alias :W to :w
cnoreabbrev W w
