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

let g:go_fmt_options = '-s'
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

au FileType go setl tabstop=4 shiftwidth=4 noexpandtab autoindent
au FileType go set colorcolumn=140

au FileType c setl tabstop=8 shiftwidth=8 noexpandtab autoindent
au FileType js setl tabstop=4 shiftwidth=4 expandtab autoindent

au FileType markdown.pandoc setl wrap
au FileType markdown.pandoc setl spell spelllang=en_US

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
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'

" --- Go ---
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"
" -- Python ---
Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'python-mode/python-mode'
"
" Vue
" Plug 'posva/vim-vue'

" C++
Plug 'octol/vim-cpp-enhanced-highlight'

" -- Markdown -- 
" tabular plugin is used to format tables
Plug 'godlygeek/tabular'

" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

" Distraction-free
Plug 'junegunn/goyo.vim'

" CoPilot
Plug 'github/copilot.vim'
call plug#end()

packadd! dracula_pro

" Some settings to enable the theme:
syntax enable     " Use syntax highlighting
set termguicolors     " enable true colors support
set background=dark
"let g:gruvbox_invert_selection=0
"let g:gruvbox_italic=1
"colorscheme base16-gruvbox-dark-hard
let base16colorspace=256  " Access colors present in 256 colorspace

let g:dracula_colorterm = 0

" colorscheme dracula_pro
colorscheme catppuccin

" Lightline
let g:lightline = {
      \ 'colorscheme': 'catppuccin',
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

" deoplete for golang
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})

map <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" NERDTree
map <F3> :NERDTreeToggle<CR>
map <F6> :TagbarToggle<CR>

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = ''

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

nmap <F8> :Rg <C-r><C-w><CR>

" golang stuff
au FileType go nmap <F4> :GoAlternate<CR>
au FileType go nnoremap <Leader>t :GoTest<CR>
au FileType go nnoremap <Leader>c :GoCoverageToggle<CR>

" Fugitigve stuff
nnoremap <C-S> :Gtabedit :<CR>:set previewwindow<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
