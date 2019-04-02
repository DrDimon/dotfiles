"BEGIN VUNDLE
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  set rtp+=~/.fzf
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  "BEGIN PLUGINS
    Plugin 'airblade/vim-gitgutter'
    Plugin 'AndrewRadev/splitjoin.vim'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'ericcurtin/CurtineIncSw.vim'
    Plugin 'godlygeek/tabular' "before vim-markdown
    Plugin 'gabrielelana/vim-markdown'
    Plugin 'jceb/vim-orgmode'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'junegunn/fzf.vim'
    Plugin 'junegunn/goyo.vim'
    Plugin 'junegunn/limelight.vim'
    Plugin 'junegunn/seoul256.vim'
    Plugin 'kblin/vim-fountain'
    Plugin 'matze/vim-move'
    Plugin 'mbbill/undotree'
    Plugin 'mileszs/ack.vim'
    Plugin 'Olical/vim-enmasse'
    Plugin 'RRethy/vim-illuminate'
    Plugin 'scrooloose/nerdtree'
    Plugin 'SirVer/ultisnips'
    Plugin 'tommcdo/vim-exchange'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'vim-pandoc/vim-pandoc'
    Plugin 'vim-pandoc/vim-pandoc-syntax'
    Plugin 'vim-scripts/darkbone.vim'
    Plugin 'vim-scripts/replacewithregister'
    Plugin 'vim-voom/VOoM'
    Plugin 'wellle/targets.vim'
    Plugin 'wting/gitsessions.vim'
    Plugin 'xuyuanp/nerdtree-git-plugin'
    Plugin 'drdimon/vim-revytex'
    " JOBXX
    " Mojolicious highlighting
    Plugin 'yko/mojo.vim'
    " JSON highlighting
    Plugin 'elzr/vim-json'
    " Bedre perl highlighting
    Plugin 'vim-perl/vim-perl'
    " LESS-highlighting
    Plugin 'groenewege/vim-less'
    " Bedre javascript highlighting
    Plugin 'pangloss/vim-javascript'
  "END PLUGINS
  call vundle#end()
"END VUNDLE

" Colorsettings
"set termguicolors
"colorscheme base16-default-dark
colorscheme seoul256
set background=dark
let g:seoul256_background = 233
colo seoul256
syntax enable

" BEGIN PLUGIN SETTINGS:
" gitgutter, illuminate:
  set updatetime=100
  nmap sm <Plug>GitGutterStageHunk
  nmap sn <Plug>GitGutterUndoHunk
  nmap sb <Plug>GitGutterPreviewHunk

" SplitJoin
  nmap sj :SplitjoinSplit<cr>
  nmap sk :SplitjoinJoin<cr>

" ctrlp:
  let g:ctrlp_working_path_mode = 1
  let g:ctrlp_max_files = 0
  let g:ctrlp_max_depth = 50
  let g:ctrlp_extensions = ['line', 'changes']
    let g:ctrlp_custom_ignore = {
    \ 'dir':  'bin/',
    \ 'file': '\v\.(po|pot)$|bin/',
\ }

" easymotion
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXY1234567890'
  let g:EasyMotion_smartcase = 1
  nmap  ss <Plug>(easymotion-overwin-f)
  vmap  ss <Plug>(easymotion-bd-f)
  nmap  se <Plug>(easymotion-overwin-line)
  vmap  se <Plug>(easymotion-bd-jk)
  nmap  sw <Plug>(easymotion-overwin-w)
  vmap  sw <Plug>(easymotion-bd-w)
  nmap  ½ <Plug>(easymotion-sl)
  vmap  ½ <Plug>(easymotion-sl)

"  CurtineIncSw (header/source swithc)
  nmap sh :call CurtineIncSw()<CR>

" Easy align
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

" FZF
" Make Ctrl-P do the right thing
  nnoremap <c-p> :call fzf#run(fzf#wrap({'source': 'find . -type f' }))<cr>

" Goyo (distraction free environment)
  let g:goyo_width = '60%'
  let g:goyo_height = '90%'
  nmap go :Goyo<CR>

  " Automatically quit if :q is called, and goyo is the only window.
  " From: https://github.com/junegunn/goyo.vim/wiki/Customization
  function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  endfunction

  function! s:goyo_leave()
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
        qa
      endif
    endif
  endfunction

  autocmd! User GoyoEnter call <SID>goyo_enter()
  autocmd! User GoyoLeave call <SID>goyo_leave()

" vim-move
  let g:move_key_modifier = 'C'

" illuminate
  let g:Illuminate_ftblacklist = ['nerdtree']
  hi illuminatedWord cterm=underline gui=underline

" Nerdtree
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  "If the last buffer is NERDtree, then vim will close:
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Revytex
  let g:revytex_default_author = 'Simon'

" Ultisnips
  let g:UltiSnipsEditSplit="tabdo"
  " This fixes problem when using ${VISUAL} in snippets:
  " From: https://github.com/roxma/nvim-completion-manager/issues/38
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" airline

" gitsessions
  nnoremap <leader>gss :GitSessionSave<cr>
  nnoremap <leader>gsl :GitSessionLoad<cr>
  nnoremap <leader>gsd :GitSessionDelete<cr>

" END PLUGIN SETTINGS:

" General Settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.pdf
set viminfo^=%
set number
set backspace=eol,start,indent
set wildmode=longest,list

" Enable mouse to use scrollwhell properly, but disable mouse buttons
" to avoid random clicking on a laptop:
"noremap <LeftMouse> <nop>
"noremap <2-LeftMouse> <nop>
"noremap <LeftDrag> <nop>
"noremap <LeftRelease> <nop>
"noremap <RightMouse> <nop>
"noremap <2-RightMouse> <nop>
"noremap <RightDrag> <nop>
"noremap <RightRelease> <nop>
set scrolloff=3
set mouse=a
map <ScrollWheelDown> <C-E>
map <ScrollWheelUp> <C-Y>

" Spelling:
" set spell
" set spelllang=da
" set spelllang=en

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
" better scroll:
map J <C-E>
map K <C-Y>

" Tab navigation:
au TabLeave * let g:lasttab = tabpagenr()
nnoremap gb :exe "tabn ".g:lasttab<cr>
nnoremap H gT
nnoremap L gt

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe "normal! g`\"" |
  \ endif

" Set custom tabline:
" mostly from :help setting-tabline
  hi User9 term=bold cterm=bold

  function NumberedTabs()
    let s = ''
    for i in range(tabpagenr('$'))
      " select the highlighting
      if i + 1 == tabpagenr()
        let s .= '%#TabLineSel#'
      else
        let s .= '%#TabLine#'
      endif

      " set the tab page number (for mouse clicks)
      let s .= '%' . (i + 1) . 'T'

      " Create label:
      let buflist = tabpagebuflist(i+1)
      let winnr = tabpagewinnr(i+1)

      " Number each tab:
      let s .= i+1

      " Display + or - if modified or not:
      let modified = 0
      for b in buflist " Loop all buffers in this tab:
        if getbufvar( b, "&modified" )
          let modified = 1
        endif
      endfor
      let s .= modified ? '%9*+%*' : '-'

      " Write filename:
      let name = bufname(buflist[winnr - 1])
      let s .= name == '' ? 'New' : name

      let s .= ' '

    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    return s
  endfunction

  set tabline=%!NumberedTabs()

 filetype plugin indent on

"= END CUSTOM TABLINE ======================

"" Auto Session:
"function! MakeSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  if (filewritable(b:sessiondir) != 2)
"    exe 'silent !mkdir -p ' b:sessiondir
"    redraw!
"  endif
"  let b:filename = b:sessiondir . '/session.vim'
"  exe "mksession! " . b:filename
"endfunction
"
"function! LoadSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  let b:sessionfile = b:sessiondir . "/session.vim"
"  if (filereadable(b:sessionfile))
"    exe 'source ' b:sessionfile
"  else
"    echo "No session loaded."
"  endif
"endfunction
"au VimEnter * nested :call LoadSession()
"au VimLeave * :call MakeSession()
