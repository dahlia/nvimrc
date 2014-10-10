"No compatibility to traditional vi
set nocompatible

"Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Plugin list ------------------------------------------------------------------

Plugin 'altercation/vim-colors-solarized'
Plugin 'Mustang2'
Plugin 'Railscasts-Theme-GUIand256color'
Plugin 'darktango.vim'
Plugin 'junegunn/seoul256.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'lepture/vim-jinja'
if version < 704
  Plugin 'JulesWang/css.vim'
endif
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'stephpy/vim-yaml'

Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'rhysd/committia.vim'

"End plugin list --------------------------------------------------------------
call vundle#end()
filetype plugin indent on

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

"Use mouse.
set mouse=a

"More tabs
set tabpagemax=25

filetype plugin on

"Some additional syntax highlighters.
au! BufRead,BufNewFile *.wsgi setfiletype python
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
au FileType lua    setl ts=2 sw=2 sts=2
au FileType haml   setl ts=2 sw=2 sts=2
au FileType sass   setl ts=2 sw=2 sts=2
au FileType scss   setl ts=2 sw=2 sts=2
au FileType make   setl ts=4 sw=4 sts=4 noet
au FileType gitcommit setl spell

"Markdown-related configurations.
augroup mkd
  autocmd BufRead *.markdown set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkdn     set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkd      set formatoptions=tcroqn2 comments=n:> spell
augroup END

"English spelling checker.
setlocal spelllang=en_us

"Keep 80 columns.
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
autocmd WinEnter * match OverLength /\%81v.\+/

"gVim-specific configurations (including MacVim).
if has("gui_running")
  colorscheme solarized
  set background=dark
  set guioptions=egmrLt
  set linespace=1
endif

"MacVim-specific configurations.
if has("gui_macvim") || has("gui_vimr")
  set imd
  set guifont=Source_Code_Pro_Light:h16.00
endif

"GVim under GNOME
if has("gui_gnome")
  set guifont="Ubuntu Mono 11"
endif

"GVim under Windows
if has("gui_win32")
  set guifont=Consolas:h11:cANSI
endif

"Gundo -- Undo tree visualization
let g:gundo_right = 1
function s:MinheeGundoToggle()
  let l:visible = bufwinnr(bufnr("__Gundo__")) != -1
  let l:visible = l:visible || bufwinnr(bufnr("__Gundo_Preview__")) != -1
  if l:visible
    let &columns -= g:gundo_width + 1
  else
    let &columns += g:gundo_width + 1
  endif
  GundoToggle
endfunction
command! -nargs=0 MinheeGundoToggle call s:MinheeGundoToggle()
nnoremap <F5> :MinheeGundoToggle<CR>

"NERDTree
function s:MinheeTreeToggle()
  let l:visible = bufwinnr(bufnr("NERD_tree_")) != -1
  if l:visible
    let &columns -= g:NERDTreeWinSize + 1
  else
    let &columns += g:NERDTreeWinSize + 1
  endif
  NERDTreeToggle
endfunction
command! -nargs=0 MinheeTreeToggle call s:MinheeTreeToggle()
nnoremap <F4> :MinheeTreeToggle<CR>
