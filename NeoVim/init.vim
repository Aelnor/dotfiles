set nocompatible              " be iMproved, required
set number
set numberwidth=5

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

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
nmap <F8> :Ag <cword><CR>

au FileType go nmap <F5> <Plug>(go-run)
au FileType go nmap <F7> <Plug>(go-build)
au FileType go nmap <F9> :DlvToggleBreakpoint<CR>
au FileType go set tabstop=8
au FileType go set shiftwidth=8
au FileType go set noexpandtab
au FileType go set autoindent

au FileType c setl tabstop=8 shiftwidth=8 noexpandtab autoindent
au FileType js setl tabstop=4 shiftwidth=4 expandtab autoindent

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
filetype off                  " required

inoremap jj <ESC>

filetype plugin indent on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'majutsushi/tagbar'            " Class/module browser
Plugin 'tpope/vim-surround'     " Parentheses, brackets, quotes, XML tags, and more
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rking/ag.vim'

Plugin 'junegunn/vim-easy-align'

" tig
Plugin 'codeindulgence/vim-tig'
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
Plugin 'Valloric/YouCompleteMe'
call vundle#end()               " required

" Some settings to enable the theme:
syntax enable     " Use syntax highlighting
set background=dark
colorscheme solarized

let g:tagbar_autofocus = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='badwolf'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let mapleader="\<SPACE>"
"
" C-Space autocomplete
inoremap <C-space> <C-x><C-o>

let g:pymode_folding = 0

map <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F9> :set list!<CR>

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

nnoremap <Leader>o :FZF<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" enable russian keymap
set keymap=russian-jcukenmac
" by default keymap is still english switching with <C-6>
set iminsert=0
set imsearch=0


" golang stuff
au FileType go nmap <F4> :GoAlternate<CR>
au FileType go nnoremap <Leader>t :GoTest<CR>
au FileType go nnoremap <Leader>c :GoCoverageToggle<CR>
