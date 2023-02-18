let mapleader=" "

"code highlight"
syntax on
"row number"
set number
"no relative number"
set norelativenumber
"show cursorline"
set cursorline
set wrap
"show the input and execute command below"
set showcmd
"command prompt use TAB in command mode"
set wildmenu
"no compatible with vi"
set nocompatible
"some configurations of TAB"
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set scrolloff=5
"different cursor styles in INSERT mode and NORMAL mode"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"Automatically switch the directory to the directory where the current file is located"
set autochdir
"highlight search results"
set hlsearch
"close highlight search results when reload vim"
exec "nohlsearch"
"highlight search results when typing"
set incsearch
"ignore uppercase and lowercase"
set ignorecase
set smartcase
"previous and next search results"
noremap = nzz
noremap - Nzz
"execute no hlsearch"
noremap <LEADER><CR> :nohlsearch<CR>

"arrow key map"
noremap j h
noremap k j
noremap i k
"quick scroll"
noremap U 5k
noremap D 5j
"ESC"
inoremap jj <ESC>
"map the mapped key i insert"
noremap n i
"s will delete the current character and enter write mode,the usage of this operation is low,so close this operation"
map s <nop>
"map save,quit and resource vimrc hot keys"
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
"split screen operation"
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>
"switch window in split window operation"
map <LEADER>l <C-w>l
map <LEADER>i <C-w>k
map <LEADER>j <C-w>h
map <LEADER>k <C-w>j
"resize the window in split window operation"
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

call plug#end()

"gruvbox configuration"
let g:airline_powerline_fonts = 1
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

"coc extensions"
let g:coc_global_extensions = [
  \'coc-vimlsp',
  \'coc-json',
  \'coc-marketplace',
  \'coc-clangd',
  \'coc-jedi',
  \'coc-explorer',
  \'coc-snippets',
  \'coc-tabnine']

"use tt open coc-explorer"
nnoremap tt :CocCommand explorer<CR>

set encoding=utf-8
set updatetime=100

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `<LEADER>-` and `<LEADER>+` to navigate diagnostics
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
