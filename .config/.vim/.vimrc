" neovim setting
if !has('nvim')
    syntax on
    set autoindent
    source autoread
    set backspace=indent,eol,start
    set belloff=all
    set cscopeverbose
    set complete-=i
    set display=lastline,msgsep
    set encoding=utf-8
    set filechars=vert:l,fold:
    set formatoptions=tcqj
    set fsync
    set history=10000
    set hlsearch
    set incsearch
    set langnoremap
    set laststatus=2
    set listchars=tab:>\ ,trail:-,nbsp:+
    set nrformats=bin,hex
    set ruler
    set sessionoptions-=options
    set shortmess=F
    set showcmd
    set sidescroll=1
    set smarttab
    set tabpagemax=50
    set tags=./tags;,tags
    set ttimeoutlen=50
    set ttyfast
    set viminfo+=!
    set wildmenu
endif

" insertを抜けるときにIMEをオフにする
if executable('fcitx')
   autocmd InsertLeave * :call system('fcitx-remote -c')
   autocmd CmdlineLeave * :call system('fcitx-remote -c')
endif

" sets the language of the manu
set langmenu=en_US.UTF-8    
" sets the language of the message
language en_US.UTF-8        
" シンタックスハイライトをon
syntax on 			        
" ファイルタイプに基づいたインデントをON
filetype plugin indent on 	
" 新しい行をはじめる時に自動でインデント
set autoindent 			    
" タブをスペースに変換
set expandtab			    
" タブをスペース4文字にする
set tabstop=4			    
" 自動インデントに使われるスペースの数
set shiftwidth=4		    
" バックスペースの挙動を修正
set backspace=2			    
" show line number
set number                  
" set fold indent
set foldmethod=indent
set foldlevel=8
" set wildmenu
set wildmode=list:longest,full
" set vsplit as openright
set splitright

set clipboard+=unnamed,unnamedplus

set runtimepath+=~/dev/vim-algomethod-tester
" set color sheme
" set background=dark
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 

" set key mapping
let mapleader = "\<space>"
" nnoremap <c-a> gg0vG$
" set jj to esc 
inoremap <silent> jj <ESC>
" set っｊ to esc
inoremap <silent> っｊ <ESC>
" set blucket
" inoremap ' ''<esc>i
" inoremap " ""<esc>i
" inoremap ( ()<esc>i
" inoremap { {}<esc>i
" inoremap [ []<esc>i

" set window move
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-w><c-v> :resize
nnoremap <c-w><c-s> :vertical resize

" terminal mode
tnoremap <esc> <c-\><c-n>
tnoremap <leader>q :bd!<cr>

nnoremap $e :edit $HOME/.vimrc<cr>
nnoremap $r :w<cr>:source $HOME/.vimrc<cr>
nnoremap $s :w<cr>;source %<cr>
nnoremap $p :PlugInstall<cr>

" nerdtree keymap
nnoremap <leader>gd :YcmCompleter GoTo<cr>

" load dein.vim
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

if &compatible
    set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
    call dein#load_toml('~/.vim/dein_lazy.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

" debug speed
function! ProfileCursorMove() abort
  let profile_file = expand('~/.vim/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction
