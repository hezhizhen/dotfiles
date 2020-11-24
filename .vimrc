" TODO: add installation of vim-plug

filetype off " required
" vim-plug
call plug#begin('~/.vim/bundle')

" languages
Plug 'fatih/vim-go'
Plug 'plasticboy/vim-markdown'

" autocompletion
Plug 'shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'deoplete-plugins/deoplete-go'

" unclassified
Plug 'kannokanno/previm'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'wakatime/vim-wakatime'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

call plug#end()

" filetype
filetype plugin on
filetype indent on
" syntax
syntax enable
syntax on

" General
set nocompatible
set nobackup
set noswapfile
set colorcolumn=80,120
set splitright
set splitbelow
set mmp=2000

" encoding
set encoding=utf8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030 " encoding for reading files (in order)
set termencoding=utf-8

" show
set number
set showmatch " highlight matching [{()}]
set ruler " 右下角显示状态栏
set showcmd " show command in bottom bar
set noshowmode " 左下角的状态栏不显示--INSERT--之类的信息

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" tab
set expandtab " tabs are spaces
set smarttab

" indent
set autoindent
set smartindent
set cindent
set shiftwidth=4 
set tabstop=4     " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing

" indent use backspace to delete indent
" eol use backspace to delete line at begining
" start delete char you just typed in
set backspace=indent,eol,start
set wildmenu " visual autocomplete for command menu
set linebreak " do not break words
set whichwrap+=<,>,h,l
set nowrap
set laststatus=2
set statusline+=%{fugitive#statusline()}
set foldmethod=indent
set hidden
set clipboard+=unnamed " share clipboard with system
set nowb
set confirm
let g:rehash256 = 1
set t_Co=256
set background=dark
set termguicolors " 支持真彩色
colorscheme gruvbox
if has("gui_running")
    " gui part (macvim) :he guicursor
    set guifont=DroidSansMono\ Nerd\ Font:h12
    " set guifontwide=WenQuanYi\ Micro\ Hei:h12
    set guicursor=n-v-c:ver25
    set guioptions-=L " hide scroll bar on the left
    set guioptions-=r " hide scroll bar on the right
    colorscheme gruvbox
    set linespace=0 " linespace
    " set fu " fullscreen when open
endif
let mapleader="\<Space>"
inoremap ;; <esc>
nnoremap B ^
nnoremap E $
nnoremap <leader><space> :nohlsearch<CR>

" Go
" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)

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
" let g:syntastic_mode_map    = {'mode': 'active', 'passive_filetypes': ['go']}
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_list_type          = "quickfix"
let g:go_auto_type_info     = 1
let g:go_updatetime         = 1000 " 1000ms
let g:go_guru_scope         = ["..."]
let g:go_implements_mode = 'gopls'

" open :GoDeclsDir with ctrl-d
nmap <C-d> :GoDeclsDir<cr>
imap <C-d> <esc>:<C-u>GoDeclsDir<cr>

" CTRL-], :GoDef, goto definition/declaration
" :GoDecls, show all function and type declarations for the current file, if [file] is not specified
" :GoDeclsDir, show all function and type declarations for the current dir, if [file] is not specified
" :GoReferrers, show the set of identifiers that refer to the same object as does the selected identifier
nmap <leader>re :GoReferrers<CR>
" :GoAlternate, jump to related test file, or vice versa
nmap <leader>rf :GoAlternate<CR>
" :GoImplements, show all implements of an interface
nmap <leader>im :GoImplements<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" nerdtree settings
let NERDTreeShowHidden = 1 " show hidden files
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <F2> :NERDTreeToggle<CR>
" open nerdtree with current file selected
nmap <silent><F1> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" airline settings
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
" airline extensions
" wordcount
let g:airline#extensions#wordcount#filetypes = ['all']
" tabline
let g:airline#extensions#tabline#enabled = 1 " 开启tabline
let g:airline#extensions#tabline#buffer_nr_show = 1 " tabline中buffer显示编号
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" whitespace
let g:airline#extensions#whitespace#enabled = 0 " 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#symbol = '|'
nnoremap <C-H> :bn<CR>
nnoremap <C-L> :bp<CR>
" 映射num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
" :bd " close the buffer(what I think of a tab)
function! s:tagbar_integration()
    " statusline tells you what function you are in!
endfunction

" tagbar settings
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8_1/bin/ctags'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 64 " 设置窗口宽度。默认为40
let g:tagbar_left = 0
let g:tagbar_show_linenumbers = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" syntastic settings
nmap <leader>n :lnext<CR>
nmap <leader>p :lprevious<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0 " 是否在打开文件时检查
let g:syntastic_check_on_wq = 1 " 是否在保存文件后检查

" vim-markdown settings
autocmd BufEnter, BufRead, BufNewFile *.{md, markdown, mkd} set filetype=markdown
let g:vim_markdown_folding_disabled                       = 1
let g:tex_conceal = ""
let g:vim_markdown_math=1
let g:vim_markdown_new_list_item_indent                   = 4
set conceallevel=3
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
set shell=/bin/bash
let g:vim_markdown_toc_autofit = 1
" let g:vim_markdown_auto_insert_bullets = 0
nmap <F9> :Toc<CR>

" rainbow settings
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
" always on
au VimEnter * RainbowParenthesesToggle
au syntax * RainbowParenthesesLoadRound
au syntax * RainbowParenthesesLoadSquare
au syntax * RainbowParenthesesLoadBraces

" indentLine settings
set list lcs=tab:\|\ " 这里有个空格
let g:indentLine_setConceal=0

" vim-signify settings
let g:signify_vcs_list = ['git', 'hg']
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119 guifg=green
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167 guifg=red
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227 guifg=yellow

" gundo.vim settings
let g:gundo_prefer_python3 = 1
nnoremap <leader>u :GundoToggle<CR>

" quickrun settings
let g:quickrun_config = {
    \ "_": {
    \ "outputter": "message",
    \ },
    \ }
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>qr <Plug>(quickrun)
map <F10> :QuickRun<CR>

" Open files
nmap <leader>todo :vsp ~/Dropbox/MWeb3/docs/15832210599850.md<CR>

let g:previm_open_cmd = 'open -a Google\ Chrome'

" deoplete
let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" distraction-free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim-startify
let g:startify_bookmarks = [
    \ {'c': '~/.vimrc'}, 
    \ {'f': '~/.config/fish/config.fish'}, 
    \ {'z': '~/.zshrc'},
    \ ]
let g:startify_commands = [
    \ ':help reference',
    \ ['Vim Reference', 'h ref'],
    \ {'h': 'h ref'},
    \ ]
let g:startify_files_number = 20

" vim-devicons
" get rid of [ ] around icons in NerdTree (it has to be at the bottom of vimrc)
syntax enable
if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif
