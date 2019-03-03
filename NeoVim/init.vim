set nocompatible              " be iMproved, required
set number
set numberwidth=5


set showcmd
set autoread

set ignorecase
set smartcase

set colorcolumn=+1

set splitbelow
set splitright

set nowrap

set foldmethod=syntax
set foldlevelstart=10

""" set backspace=indent,eol,start
set timeoutlen=1000 ttimeoutlen=0

set laststatus=2

set rnu
set mouse=a

function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nmap <F4> :call SwitchSourceHeader()<CR><Paste>
nmap <F8> :Ack <cword><CR>


au FileType go nmap <F5> <Plug>(go-run)
au FileType go nmap <F7> <Plug>(go-build)
au FileType go nmap <F9> :DlvToggleBreakpoint<CR>

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

au FileType go setl tabstop=8 shiftwidth=8 noexpandtab autoindent
au FileType c setl tabstop=8 shiftwidth=8 noexpandtab autoindent
au FileType js setl tabstop=4 shiftwidth=4 expandtab autoindent

"Copy paste to/from clipboard
vnoremap <C-c> "*y
filetype off                  " required

inoremap jj <ESC>

filetype plugin indent on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'majutsushi/tagbar'            " Class/module browser
Plugin 'tpope/vim-surround'     " Parentheses, brackets, quotes, XML tags, and more
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'mileszs/ack.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/fzf'

" color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'
Plugin 'morhetz/gruvbox'

" --- Go ---
Plugin 'fatih/vim-go'
Plugin 'sebdah/vim-delve'
" -- Python ---
Bundle "lepture/vim-jinja"
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'python-mode/python-mode'
" Vue
Plugin 'posva/vim-vue'
" C++
Plugin 'octol/vim-cpp-enhanced-highlight'
call vundle#end()               " required

" Some settings to enable the theme:
syntax enable     " Use syntax highlighting
set termguicolors     " enable true colors support
set background=dark
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1
colorscheme gruvbox

let g:tagbar_autofocus = 1
let g:ackprg = 'ag --vimgrep --ignore tags'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let mapleader="\<SPACE>"
"
" C-Space autocomplete
inoremap <C-space> <C-x><C-o>

map <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" NERDTree
map <F3> :NERDTreeToggle<CR>
map <F6> :TagbarToggle<CR>

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = ''

" C++ Highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" pymode
let g:pymode_folding = 0
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1
let g:pymode_folding = 0

nnoremap <Leader>o :FZF<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" golang stuff
au FileType go nmap <F4> :GoAlternate<CR>
au FileType go nnoremap <Leader>t :GoTest<CR>
au FileType go nnoremap <Leader>c :GoCoverageToggle<CR>

" Fugitigve stuff
nnoremap <C-S> :Gtabedit :<CR>:set previewwindow<CR>
