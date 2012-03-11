"Pathogen
call pathogen#runtime_append_all_bundles()

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

filetype plugin on

"Some additional syntax highlighters.
au! BufRead,BufNewFile *.wsgi setfiletype python
au! BufRead,BufNewFile *.sass setfiletype sass
au! BufRead,BufNewFile *.haml setfiletype haml
au! BufRead,BufNewFile *.less setfiletype less

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
  autocmd BufRead *.markdown set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkdn     set formatoptions=tcroqn2 comments=n:> spell
  autocmd BufRead *.mkd      set formatoptions=tcroqn2 comments=n:> spell
augroup END

"English spelling checker.
setlocal spelllang=en_us

"Keep 80 columns.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"gVim-specific configurations (including MacVim).
if has("gui_running")
  colorscheme solarized
  set background=dark
  set guioptions=egmrLt
  set linespace=1
endif

"MacVim-specific configurations.
if has("gui_macvim")
  set imd
  set guifont=DejaVu_Sans_Mono:h12.00
endif

"GVim under GNOME
if has("gui_gnome")
  set guifont="Ubuntu Mono 12"
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

