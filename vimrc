" 设置不兼容VI模式，在增强模式下运行
set nocompatible              
" 覆盖文件时不备份
set nobackup
" 不启用交换文件
set noswapfile
" 保存文件格式
" set fileformats=unix
" 读文件时，使用的编码（顺序）
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
" 保存时，使用的编码
" set fileencoding=utf-8
" 终端上使用的编码
set termencoding=utf-8
" 程序使用的编码
set encoding=utf-8
" 记录历史行数
" set history=500
" 自动切换目录
" set autochdir
" 搜索时忽略大小写
set ignorecase 

" Vundle
filetype off " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Languages
Plugin 'fatih/vim-go'
Plugin 'dag/vim-fish'
Plugin 'elzr/vim-json'
Plugin 'zaiste/tmux.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'nvie/vim-flake8'

" Themes
Plugin 'tomasr/molokai'
" Plugin 'crusoexia/vim-monokai'
" Plugin 'sickill/vim-monokai'
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'
Plugin 'tyrannicaltoucan/vim-quantum'
Plugin 'keitanakamura/neodark.vim'
Plugin 'ajmwagar/vim-deus'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plugin 'godlygeek/tabular'
" easy-align is similar to the above 
Plugin 'Shougo/neocomplete.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'wakatime/vim-wakatime'
Plugin 'Yggdroot/indentLine'
Plugin 'suan/vim-instant-markdown'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'mhinz/vim-signify'
Plugin 'rking/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'thinca/vim-quickrun'
Plugin 'wannesm/wmgraphviz.vim'

call vundle#end()         " required
filetype plugin indent on " required
syntax enable             " 语法开启
syntax on


function! BasicSettings() abort
    " indent use backspace to delete indent
    " eol use backspace to delete line at begining
    " start delete char you just typed in 
    set backspace=indent,eol,start

    " show relative number and absolute number
    set relativenumber
    set number

    " show command in bottom bar
    set showcmd
    
    " indent
    set autoindent 
    set smartindent
    set cindent

    " visual autocomplete for command menu
    set wildmenu 

    " do not break words
    set linebreak

    " tab options
    set tabstop=4     " number of visual spaces per TAB
    set expandtab     " tabs are spaces
    set softtabstop=4 " number of spaces in tab when editing
    set shiftwidth=4
    set smarttab

    " autoread file
    " set autoread

    " search
    set hlsearch
    set incsearch " search as characters are entered
    " set nowrapscan " do not re-search when the first/last one that matches

    set whichwrap+=<,>,h,l
    set nowrap
endfunction

call BasicSettings()

" settings
let mapleader="\<Space>" " space as <leader>
" ;; is escape
inoremap ;; <esc>
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
set background=dark
set termguicolors " 支持真彩色
" colorscheme molokai
colorscheme gruvbox
if has("gui_running")
    " gui part (macvim) :he guicursor
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12 
    set guifontwide=Microsoft\ YaHei:h12
    set guicursor=n-v-c:ver25
    set guioptions-=L " hide scroll bar on the left 
    set guioptions-=r " hide scroll bar on the right
    colorscheme gruvbox
    " colorscheme quantum
endif
" colorscheme quantum
" highlight Normal ctermfg=252 ctermbg=none
" 终端上使用的编码
set laststatus=2
set statusline+=%{fugitive#statusline()}
set noshowmode " 左下角的状态栏不显示--INSERT--之类的信息
set ruler " 右下角显示状态栏
set smartcase
set foldmethod=indent
" set foldlevel=99
set splitright
set splitbelow
set hidden
set clipboard+=unnamed " share clipboard with system

" backup
set nowb

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 

set confirm


set showmatch " highlight matching [{()}]

" move
" nnoremap j gj
" nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap <leader>w :w<CR>
nnoremap <Leader>q :q<CR>


" nerdtree settings
let NERDTreeShowHidden=1 " show hidden files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <F2> :NERDTreeToggle<CR>
" open nerdtree with current file selected
nmap <silent><F1> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" airline settings
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1

let g:airline_theme='powerlineish'
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分割字符
let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#right_sep = ''
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_alt_sep = ''
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#show_tab_nr = 1 " display tab number in tabs mode
"let g:airline#extensions#tabline#tab_nr_type = 2
"let g:airline#extension#tabline#show_tab_type = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '|'
nnoremap <C-H> :bn<CR>
nnoremap <C-L> :bp<CR>
" 映射num buffer
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
"nnoremap <F1> :bn<CR>
"nnoremap <F3> :bp<CR>
" :bd " close the buffer(what I think of a tab)
" let g:airline_section_b = '%{getcwd()}'
let g:airline_section_b = '%{fugitive#statusline()}'
" let g:airline_section_c = '%{fugitive#statusline()}'
"let g:airline_section_c = '%{strftime("%T")}'
let g:airline_section_c = '%f  %{strftime("%T")}'
" let g:airline_section_gutter = airline#section#create(['BN: %{bufnr("%")}','%='])
" let g:airline_section_c = '%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline_section_c = airline#section#create_right(['%f'])
" let g:airline_section_x = airline#section#create_right(['branch', 'ffenc'])
" let g:airline_section_y = '%Y'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
let g:airline_symbols.space = "\ua0"
function! s:tagbar_integration()
    " statusline tells you what function you are in!
endfunction


" ctags settings
let Tlist_Ctags_Cmd ='/usr/local/Cellar/ctags/5.8_1/bin/ctags'  "这里比较重要了，设置ctags的位置，不是指向MacOS自带的那个，而是我们用homebrew安装的那个，Centos下配置注销这行即可。

" taglist settings
let Tlist_Use_Right_Window = 1        " 让taglist窗口出现在Vim的右边
let Tlist_File_Fold_Auto_Close = 1    " 当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来。
let Tlist_Show_One_File = 1           " 只显示一个文件中的tag，默认为显示多个
let Tlist_Sort_Type ='name'           " Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序
let Tlist_GainFocus_On_ToggleOpen = 1 " Taglist窗口打开时，立刻切换为有焦点状态
let Tlist_Exit_OnlyWindow = 1         " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 32               " 设置窗体宽度为32，可以根据自己喜好设置
map <silent> <F9> :TlistToggle <CR>

" tagbar settings
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_width = 64 " 设置窗口宽度。默认为40
let g:tagbar_left = 0
let g:tagbar_show_linenumbers = 1
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

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" ctrlp settings
if executable('ag')
    " use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " use ag in ctrlp for listing files
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that ctrlp doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux


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

" vim-go settings 
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_fields    = 1
let g:go_highlight_types     = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'gofmt']
"let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
let g:go_updatetime = 1000 " 1000ms
let g:go_guru_scope = ["..."]

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

" neocomplete settings 
" Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
 let g:neocomplete#sources#syntax#min_keyword_length = 2

 " Plugin key-mappings.
 inoremap <expr><C-g>     neocomplete#undo_completion()
 inoremap <expr><C-l>     neocomplete#complete_common_string()

 " Recommended key-mappings.
 " <CR>: close popup and save indent.
 inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
 function! s:my_cr_function()
     return neocomplete#close_popup() . "\<CR>"
 endfunction
 " <TAB>: completion.
 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 " <C-h>, <BS>: close popup and delete backword char.
 inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
 inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
 inoremap <expr><C-y>  neocomplete#close_popup()
 inoremap <expr><C-e>  neocomplete#cancel_popup()

 " Go related mappings
 au FileType go nmap <Leader>i <Plug>(go-info)
 au FileType go nmap <Leader>gd <Plug>(go-doc)
 au FileType go nmap <Leader>r <Plug>(go-run)
 au FileType go nmap <Leader>b <Plug>(go-build)
 au FileType go nmap <Leader>t <Plug>(go-test)
 au FileType go nmap gd <Plug>(go-def-tab)

" vim-markdown settings
au BufRead, BufNewFile *.{md, markdown, mkd} set filetype=markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 4
set conceallevel=0
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" vim-instant-markdown settings
let g:instant_markdown_autostart = 0
let g:markdown_fenced_languages = ['html', 'python', 'javascript', 'vim', 'sh', 'elasticsearch']
set shell=/bin/bash

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

" vim-signify settings
let g:signify_vcs_list = ['git', 'hg']
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" ag.vim settings
" 在搜索代码时不默认直接打开搜索的第一个结果
" nmap <c-t> :Ag! ""<left>.Ag! 
nnoremap <leader>ag :Ag!<SPACE>

" gundo.vim settings
nnoremap <leader>u :GundoToggle<CR>

" multiple-cursors settings
" default mapping
" let g:multiple_cursor_use_default_mapping=1
" let g:multiple_cursor_next_key='<C-n>'
" let g:multiple_cursor_prev_key='<C-p>'
" let g:multiple_cursor_skip_key='<C-x>'
" let g:multiple_cursor_quit_key='<Esc>'

" nmap <leader>jt :%!python -m json.tool<CR>

" vim-json settings
let g:vim_json_syntax_conceal=0

" typescript-vim settings
let g:typescript_indent_disable = 1

" quickrun settings
let g:quickrun_config = {
            \ "_": {
            \ "outputter": "message",
            \},
            \}
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>qr <Plug>(quickrun)
map <F10> :QuickRun<CR>

" graphviz
nnoremap <leader>gs :GraphvizShow<CR>
" for themes
let g:neodark#background = '#202020'
