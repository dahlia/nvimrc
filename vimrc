"Syntax highlighting.
syntax on

"Softtab -- use spaces instead tabs.
set expandtab
set tabstop=4 shiftwidth=4 sts=4
set autoindent

"I dislike CRLF.
set fileformat=unix

set backspace=2

"Detect modeline hints.
set modeline

"Prefer UTF-8.
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp949,korea,iso-2022-kr

"Use mouse.
set mouse=a

"Some additional syntax highlighters.
au! BufRead,BufNewFile *.wsgi setfiletype python
au! BufRead,BufNewFile *.sass setfiletype sass
au! BufRead,BufNewFile *.haml setfiletype haml

"These languages have their own tab/indent settings.
au FileType cpp    setl ts=2 sw=2 sts=2
au FileType ruby   setl ts=2 sw=2 sts=2
au FileType yaml   setl ts=2 sw=2 sts=2
au FileType html   setl ts=2 sw=2 sts=2
au FileType lua    setl ts=2 sw=2 sts=2
au FileType haml   setl ts=2 sw=2 sts=2
au FileType sass   setl ts=2 sw=2 sts=2
au FileType make   setl ts=4 sw=4 sts=4 noet

"Markdown-related configurations.
augroup mkd
  autocmd BufRead *.markdown set formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.mkdn     set formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.mkd      set formatoptions=tcroqn2 comments=n:>
augroup END

"English spelling checker.
setlocal spell spelllang=en_us

"Keep 80 columns.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"gVim-specific configurations (including MacVim).
if has("gui")
  colorscheme ir_black
  set guioptions=egmrLt
endif

"MacVim-specific configurations.
if has("gui_macvim")
  set imd
  set transparency=10
  set guifont=Bitstream_Vera_Sans_Mono:h12.00
endif

