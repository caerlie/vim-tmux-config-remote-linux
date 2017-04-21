" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
set background=dark             "Use dark color scheme

let mapleader = "\<Space>"

" 行番号
set number
set relativenumber
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

"Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" 改行時にインデントを引き継いで改行する
set autoindent
" インデントにつかわれる空白の数
set shiftwidth=4
" <Tab>押下時の空白数
set softtabstop=4
" <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set expandtab
" <Tab>が対応する空白の数
set tabstop=4

" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·

set autoread      " Reload files changed outside vim

" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

set smartindent

set laststatus=2
set ruler
set cursorline
set cursorcolumn
set hlsearch
set nowrap
set incsearch
set ignorecase

set visualbell    " stop that ANNOYING beeping
set wildmenu
set wildmode=list:longest,full

" tempファイルを作らない。編集中に電源落ちまくるし、とかいう人はコメントアウトで
set noswapfile
set nobackup
set nowritebackup
set history=50

set showmatch

" タブ文字の表示 ^I で表示されるよ
"set list

" Open new split panes to right and bottom, which feels more natural
set splitright
set splitbelow

" クリップボードを共有する(設定しないとvimとのコピペが面倒です)
set clipboard+=unnamed
set clipboard+=autoselect
vmap <C-c> :w !xsel -ib<CR><CR>

" インクリメント、デクリメントを16進数にする(0x0とかにしなければ10進数です。007をインクリメントすると010になるのはデフォルト設定が8進数のため)
set nf=hex
" " マウス使えます
set ttyfast
"set mouse=a

" delete bug fix
set backspace=indent,eol,start

set gcr=a:block-blinkon0
set guioptions-=m
set guioptions-=T

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

filetype on
filetype plugin on

syntax enable
syntax on

set tags=./tags,tags

" cscope 
" find . -type f -print | grep -E '\.(c(pp)?|h)$' > cscope.files
if has("cscope")
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
endif

call plug#begin('~/.vim/plugged')
"precision colorscheme for the vim text editor
Plug 'altercation/vim-colors-solarized'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Source code browser
Plug 'vim-scripts/taglist.vim'

"Vim plugin that displays tags in a window
Plug 'majutsushi/tagbar'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

"Vim plug for switching between companion source files 
Plug 'derekwyatt/vim-fswitch'

"Vim-script library
Plug 'vim-scripts/L9'

"buffer/file/command/tag/etc explorer with fuzzy matching
Plug 'vim-scripts/FuzzyFinder'

" [3] Several plugins to help work with Tmux
Plug 'christoomey/vim-tmux-navigator'

" Code highlighting and linting
Plug 'scrooloose/syntastic' "Run linters and display errors etc]

" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" A light and configurable statusline/tabline for Vim
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" Ctag
let g:ctrlp_extensions = ['tag']
" :help g:ctrlp_match_window
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
" :help g:ctrlp_working_path_mode
let g:ctrlp_working_path_mode = 'rw'

" Color Set
set t_Co=256
set mouse=a

colorscheme solarized

" Tagbar
let tagbar_width=32
let g:tagbar_compact=1
let g:tagbar_usearrows = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_width = 80

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
""Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

"" Quicker window movement
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>X :q!<CR>
nnoremap <Leader>b :NERDTreeToggle<CR>
nnoremap <Leader>B :NERDTreeFind<CR>
autocmd vimenter * NERDTree

nnoremap <Leader>s :Gstatus<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <Leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <Leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

nnoremap <silent> <C-]> g<C-]>
nnoremap <silent> <C-w>m <C-w>vg<C-]>

nmap <silent> <Leader>r :TagbarToggle<CR>
nmap <silent> <Leader>sw :FSHere<CR>
nmap <silent> <Leader>g :CtrlPTag<CR>

" Switch between the last two file
nnoremap <leader><leader> <c-^>

" [ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>

"ハイライトをヤメる
nmap <Leader>, :noh<CR><Esc>

"Switching by number
nnoremap <F5> :buffers<CR>:buffer<Space>

"au FocusLost,WinLeave * :silent! wa
"autocmd VimResized * :wincmd =
"autocmd BufEnter * silent! cd %:p:h

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap 0p "0p
vmap 0P "0P
nmap 0p "0p
nmap 0P "0P

" cscope key
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<cR><CR>

" split instead of a horizontal one
nmap <C-\>S :vert scs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>G :vert scs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>C :vert scs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>T :vert scs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>E :vert scs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>F :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>I :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>D :vert scs find d <C-R>=expand("<cword>")<cR><CR>

" vs mode search with *
vnoremap * "zy:let @/ = @z<CR>n

" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 編集中のファイルパスをクリップボードにコピーする
function! g:CopyFilePath()
  let @+ = expand("%:p")
  echo @+
endfunction
 
" 編集中のファイル名をクリップボードにコピーする
function! g:CopyFileName()
  let @+ = expand("%:t")
  echo @+
endfunction
 
" 編集中のファイルの存在するフォルダのパスをクリップボードにコピーする
function! g:CopyFolderPath()
  let @+ = expand("%:p:h")
  echo @+
endfunction
 
" コマンドとして実行できるようにする
command! CopyFilePath :call g:CopyFilePath()
command! CopyFileName :call g:CopyFileName()
command! CopyFolderPath :call g:CopyFolderPath()

