" automatically install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'MattesGroeger/vim-bookmarks'

call plug#end()

set number
colorscheme onedark
set noswapfile
set nobackup
let mapleader="\<Space>"
inoremap ;; <esc>
set expandtab " tabs are spaces
set smarttab
set autoindent
set smartindent
set cindent
set shiftwidth=4
set tabstop=4     " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set hlsearch
set incsearch
set ignorecase
set smartcase
set clipboard+=unnamed " share clipboard with system
set colorcolumn=80,120
nnoremap <leader><space> :nohlsearch<CR>

" Go
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0 " 参数和类型不能兼得，我选择类型高亮
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath  = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
let g:go_updatetime = 1000 " 1000ms
let g:go_guru_scope = ["..."]
let g:go_implements_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_info_mode = 'gopls'

" Search
let g:Lf_ShortcutF = '<C-P>' " default: <leader>f
let g:Lf_ShortcutB = '<C-B>' " default: <leader>b
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlColorscheme = 'onedark' " default: default
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ShowHidden = 1
let g:Lf_PreviewInPopup = 1

" Bookmark
let g:bookmark_auto_save_file = $HOME.'/.config/nvim/.vim-bookmarks'
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
