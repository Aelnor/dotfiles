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

au FileType go setl tabstop=4 shiftwidth=4 noexpandtab autoindent
au FileType c setl tabstop=8 shiftwidth=8 noexpandtab autoindent
au FileType js setl tabstop=4 shiftwidth=4 expandtab autoindent

au FileType markdown.pandoc setl wrap
au FileType markdown.pandoc setl spell spelllang=en_US

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
Plug 'arcticicestudio/nord-vim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" --- Go ---
Plug 'fatih/vim-go'
Plug 'sebdah/vim-delve'
"
" -- Python ---
Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'python-mode/python-mode'
"
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

" Plug 'OmniSharp/omnisharp-vim'
call plug#end()

" Some settings to enable the theme:
syntax enable     " Use syntax highlighting
set termguicolors     " enable true colors support
set background=dark
"let g:gruvbox_invert_selection=0
"let g:gruvbox_italic=1
colorscheme base16-gruvbox-dark-hard
let base16colorspace=256  " Access colors present in 256 colorspace

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:tagbar_autofocus = 1
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

nnoremap <Leader>o :Files<CR>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


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

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
