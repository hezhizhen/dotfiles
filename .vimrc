filetype off " required
" vim-plug
call plug#begin('~/.vim/bundle')

" languages
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'plasticboy/vim-markdown'
Plug 'stephpy/vim-yaml'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" autocompletion
" Plug 'shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'

" beautification
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'

" unclassified
Plug 'kannokanno/previm'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

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
set splitbelow
set splitright
set mmp=2000

" encoding
set encoding=utf-8
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
" eol use backspace to delete line at beginning
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
let g:onedark_termcolors=256
colorscheme onedark
if has("gui_running")
    " gui part (macvim) :he guicursor
    set guifont=DroidSansMono\ Nerd\ Font:h12
    "set guifontwide=Sarasa\ Mono\ SC:h12
    set guicursor=n-v-c:ver25
    set guioptions-=L " hide scroll bar on the left
    set guioptions-=r " hide scroll bar on the right
    " colorscheme gruvbox
    colorscheme onedark
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
" au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
" au FileType go nmap gd <Plug>(go-def-tab)
" au filetype go inoremap <buffer> . .<C-x><C-o>

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
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 1
let g:go_updatetime = 1000 " 1000ms
let g:go_guru_scope = ["..."]
let g:go_implements_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_info_mode = 'gopls'
"let g:go_auto_sameids = 1

"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

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
" let g:airline_theme = 'powerlineish'
let g:airline_theme = 'onedark' " NOTE: be the same with colorscheme
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
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8_2/bin/ctags'
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
let g:vim_markdown_folding_disabled = 1
let g:tex_conceal = ""
let g:vim_markdown_math=1
let g:vim_markdown_new_list_item_indent = 2
set conceallevel=0
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
let g:indentLine_setConceal = 0
let g:indentLine_char = '⦙'

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

" undotree settings
nnoremap <leader>u :UndotreeToggle<CR>
" https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L15
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 4
endif

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
" let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" coc
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" distraction-free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" LeaderF settings
let g:Lf_ShortcutF = '<C-P>' " default: <leader>f
let g:Lf_ShortcutB = '<C-B>' " default: <leader>b
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlColorscheme = 'onedark' " default: default
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ShowHidden = 1
let g:Lf_PreviewInPopup = 1

" vim-startify
let g:startify_bookmarks = [
    \ {'c': '~/.vimrc'}, 
    \ {'a': '~/.config/alacritty/alacritty.yml'},
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
