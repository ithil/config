" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle "garbas/vim-snipmate"
NeoBundle "kana/vim-fakeclip"
NeoBundle "ervandew/supertab"
NeoBundle "Raimondi/delimitMate"
NeoBundle "tpope/vim-surround"
NeoBundle "vim-scripts/YankRing.vim"
NeoBundle "ahayman/vim-nodejs-complete"
NeoBundle "jamescarr/snipmate-nodejs"
NeoBundle "moll/vim-node"
NeoBundle "walm/jshint.vim"
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle "bling/vim-airline"
NeoBundle "terryma/vim-multiple-cursors"
NeoBundle "vim-scripts/wombat256.vim"
NeoBundle "tomtom/tcomment_vim"
NeoBundle "kana/vim-textobj-user"
NeoBundle "beloglazov/vim-textobj-quotes"

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set number
set cursorline
set ruler
syntax on
filetype plugin on
filetype indent on
set hlsearch
set incsearch
set t_Co=256
set mouse=a
set ignorecase
set smartcase

color jellybeans

" Indention stuff
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent

set wrap
set encoding=utf-8
set pastetoggle=<F5>

set wildmode=longest,list,full
set wildmenu

let mapleader = ","
map <Leader>r :let @/ = ""<CR>

cmap w!! w !sudo tee % >/dev/nul
let g:yankring_history_dir = '~/.vim/'

set laststatus=2
