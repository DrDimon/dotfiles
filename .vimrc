"BEGIN VUNDLE
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  "BEGIN PLUGINS
    Plugin 'airblade/vim-gitgutter'
    Plugin 'chriskempson/base16-vim'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'mhinz/vim-startify'
    Plugin 'scrooloose/nerdtree'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'xuyuanp/nerdtree-git-plugin'
  "END PLUGINS
  call vundle#end()
  filetype plugin indent on
"END VUNDLE

" BEGIN PLUGIN SETTINGS:
" gitgutter
  set updatetime=100

" ctrlp:
  let g:ctrlp_max_files = 0
  let g:ctrlp_max_depth = 50
  let g:ctrlp_extensions = ['line', 'changes']

" easymotion
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
  nmap  ss <Plug>(easymotion-overwin-f)
  vmap  ss <Plug>(easymotion-bd-f)
  nmap  se <Plug>(easymotion-overwin-line)
  vmap  se <Plug>(easymotion-bd-jk)
  nmap  sw <Plug>(easymotion-overwin-w)
  vmap  sw <Plug>(easymotion-bd-w)
  nmap  sj <Plug>(easymotion-w)
  vmap  sj <Plug>(easymotion-w)
  nmap  sk <Plug>(easymotion-b)
  vmap  sk <Plug>(easymotion-b)

" Nerdtree
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  "If the last buffer is NERDtree, then vim will close:
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" airline

" END PLUGIN SETTINGS:

" Colorsettings
set termguicolors
colorscheme base16-default-dark

" General Settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.pdf
set scrolloff=3
set mouse=a
set viminfo^=%
set number
set backspace=eol,start,indent
syntax enable

" Good undo:
set undodir=~/.vim/undodir
set undofile

" Tab settings
set expandtab
set shiftwidth=2
set tabstop=2

" General Keymaps
map <space> /
map <C-space> ?
imap lkj <ESC>
command W w
nmap st :term<CR>
vmap st :term<CR>
" Window movement:
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe "normal! g`\"" |
  \ endif
