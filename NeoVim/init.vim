set nocompatible              " be iMproved, required
set number
set numberwidth=5

set shell=/bin/zsh


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

nmap <F4> :call SwitchSourceHeader()<CR>
nmap <F8> :Rg <C-r><C-w><CR>


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

call plug#begin('~/.local/share/nvim/site/autoload')
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'            " Class/module browser
Plug 'tpope/vim-surround'     " Parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree' 	    	" Project and file navigation

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/vim-easy-align'

Plug 'Asheq/close-buffers.vim'
" color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" --- Go ---
Plug 'fatih/vim-go'
Plug 'sebdah/vim-delve'
" -- Python ---
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'python-mode/python-mode'
" Vue
Plug 'posva/vim-vue'
" C++
Plug 'octol/vim-cpp-enhanced-highlight'
" -- Markdown -- 
" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

Plug 'OmniSharp/omnisharp-vim'
call plug#end()

" Some settings to enable the theme:
syntax enable     " Use syntax highlighting
set termguicolors     " enable true colors support
set background=dark
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1
"colorscheme gruvbox
colorscheme base16-gruvbox-dark-hard
let base16colorspace=256  " Access colors present in 256 colorspace

" Lightline
" let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction


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
let g:pymode_rope = 1

let g:rustfmt_autosave = 1

nnoremap <Leader>o :FZF<CR>
nnoremap <Leader>b :Buffers<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" golang stuff
au FileType go nmap <F4> :GoAlternate<CR>
au FileType go nnoremap <Leader>t :GoTest<CR>
au FileType go nnoremap <Leader>c :GoCoverageToggle<CR>

" Fugitigve stuff
nnoremap <C-S> :Gtabedit :<CR>:set previewwindow<CR>

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_prefer_global_sln = 1 
let g:OmniSharp_server_type = 'roslyn' 

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Markdown
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0
