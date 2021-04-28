"BEGIN VUNDLE
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  set rtp+=~/Git/fzf
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'

  "BEGIN PLUGINS
    Plugin 'airblade/vim-gitgutter'
    Plugin 'AndrewRadev/splitjoin.vim'
    Plugin 'easymotion/vim-easymotion'
    "Plugin 'phaazon/hop.nvim'
    Plugin 'godlygeek/tabular' "before vim-markdown
    Plugin 'junegunn/vim-easy-align'
    Plugin 'junegunn/fzf.vim'
    Plugin 'junegunn/goyo.vim'
    Plugin 'junegunn/seoul256.vim'
    Plugin 'kblin/vim-fountain'
    Plugin 'matze/vim-move'
    Plugin 'mbbill/undotree'
    Plugin 'nelstrom/vim-visual-star-search'
    Plugin 'RRethy/vim-illuminate'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'neomake/neomake'
    Plugin 'wellle/targets.vim'
    Plugin 'rhysd/git-messenger.vim'
    if has('nvim-0.5')
      Plugin 'neovim/nvim-lspconfig'
    endif
    Plugin 'drdimon/vim-revytex'
    Plugin 'drdimon/vim-andersen'
    if has('nvim-0.5')
      Plugin 'drdimon/vim-dice'
    endif
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

call neomake#configure#automake('nrwi', 500)
let g:neomake_error_sign={'text': 'E', 'texthl': 'NeomakeErrorMsg'}
let g:neomake_warning_sign={'text': 'W', 'texthl': 'NeomakeErrorMsg'}

" Colorsettings
set termguicolors
"colorscheme base16-default-dark
colorscheme seoul256
set background=dark
let g:seoul256_background = 230
syntax enable
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" BEGIN PLUGIN SETTINGS:
" gitgutter, illuminate:
  set updatetime=100
  nmap sn <Plug>(GitGutterUndoHunk)
  nmap sb <Plug>(GitGutterPreviewHunk)

" git-messenger
  nmap sm :GitMessenger<CR>
  let g:git_messenger_include_diff = 'current'
  let g:git_messenger_max_popup_height = 20

" SplitJoin
  nmap sj :SplitjoinSplit<cr>
  nmap sk :SplitjoinJoin<cr>

" easymotion
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXY1234567890'
  let g:EasyMotion_smartcase = 1
  nmap  ss <Plug>(easymotion-overwin-f)
  vmap  ss <Plug>(easymotion-bd-f)

"  CurtineIncSw (header/source swithc)
  nmap sh :call CurtineIncSw()<CR>

" Easy align
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

" FZF
  let g:fzf_buffers_jump = 1
  nnoremap <silent> <C-P> :Files<CR>
  " Customize file search:
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/bundle/fzf.vim/bin/preview.sh {}']}, <bang>0)
  nnoremap <silent> <C-B> :Buffers<CR>
  nnoremap <silent> <C-N> :Lines<CR>
  nnoremap <silent> <C-M> :History<CR>

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
" Binding only works with neovim
  let g:move_key_modifier = 'M'

" illuminate
  let g:Illuminate_ftblacklist = ['nerdtree']
  hi illuminatedWord cterm=underline gui=underline

" Revytex
  let g:revytex_default_author = 'Simon'

" Dice
" Define macros
if has('nvim-0.5')
lua << EOF
  require'dice'.set_macros({
    fate = {
      mediocre  = 'df+1',
      average   = 'df+1',
      fair      = 'df+2',
      good      = 'df+3',
      great     = 'df+4',
      superb    = 'df+5',
      fantastic = 'df+6',
      epic      = 'df+7',
      legendary = 'df+8',
    },
    d20 = {
      normal = 'd20',
      advantage = '2d20h',
      disadvantage = '2d20l',
    },
    dh = 'd100',
  })
EOF
endif

" airline

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
set foldcolumn=0
set conceallevel=2

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
set spell
" set spelllang=da
" set spelllang=en

set backupdir=~/.vim/backupdir
set undodir=~/.vim/undodir
set undofile

" Tab settings
set expandtab
set shiftwidth=2
set tabstop=2

" navigation should work with linewarp.
set textwidth=0
set wrap linebreak
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
noremap 0 g0
noremap $ g$

" General Keymaps
noremap s <nop>
map <space> /
map <C-space> ?
imap lkj <ESC>
inoremap jj <ESC>
command W w
nmap st :term<CR>
vmap st :term<CR>
" Window movement:
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
noremap <A-w> gt
noremap <A-q> gT
noremap <A-a> :call  MoveTabLeft()<CR>
noremap <A-s> :call  MoveTabRight()<CR>

function MoveTabLeft()
    let tabnr=tabpagenr()-2
    if tabnr >= 0
        execute "tabmove " . tabnr
    endif
endfunction

function MoveTabRight()
    let tabnr=tabpagenr()+1
    if tabnr <= tabpagenr("$")
        execute "tabmove " . tabnr
    endif
endfunction

" better scroll:
map J <C-E>
map K <C-Y>

" Ctrl-X mode binding:
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

if has("nvim")
  set inccommand=split
endif

" Tab navigation:
au TabLeave * let g:lasttab = tabpagenr()
nnoremap gb :exe "tabn ".g:lasttab<cr>

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

function! ToggleClutter()
  set nonumber
  set signcolumn=no
  set foldcolumn=0
  set laststatus=0
  GitGutterDisable
endfunction

command ToggleClutter :call ToggleClutter

augroup markdown
"  autocmd Filetype markdown :inoremap <C-b> **
"  autocmd Filetype markdown :inoremap <C-i> *
"  autocmd Filetype markdown :inoremap <C-u> _
  autocmd Filetype markdown :call ToggleClutter()
augroup end

" Custom markdown functionality
nnoremap <C-b> :set opfunc=MarkdownFormatBold<cr>g@
vnoremap <C-b> :<C-U> call MarkdownFormatBold(visualmode(), 1)<cr>
nnoremap <C-i> :set opfunc=MarkdownFormatItalic<cr>g@
vnoremap <C-i> :<C-U> call MarkdownFormatItalic(visualmode(), 1)<cr>
nnoremap <C-u> :set opfunc=MarkdownFormatUnderline<cr>g@
vnoremap <C-u> :<C-U> call MarkdownFormatUnderline(visualmode(), 1)<cr>

function! MarkdownFormatBold(type, ...)
  call MarkdownFormat(a:type, a:0, "**")
endfunction
function! MarkdownFormatItalic(type, ...)
  call MarkdownFormat(a:type, a:0, "*")
endfunction
function! MarkdownFormatUnderline(type, ...)
  call MarkdownFormat(a:type, a:0, "_")
endfunction

function! MarkdownFormat(type, visual, chars)
  " Get start and end of the motion:
  let start_position = getpos("'[")
  let end_position = getpos("']")
  " If in visual mode we use the visual marks instead:
  if a:visual
    let start_position = getpos("'<")
    let end_position = getpos("'>")
  " If in linemode we change the column to the start and end of the line:
  elseif a:type == 'line'
    let start_position[2] = 0
    let end_position[2] = 9999999
  endif

  " First we append chars to the end position in order to avoid messing columns
  call setpos('.', end_position)
  exec "norm! a" . a:chars
  " Then insert at the start position
  call setpos('.', start_position)
  exec "norm! i" . a:chars
  " Finaly move the cursor to the desired place:
  call setpos('.', end_position)
endfunction
