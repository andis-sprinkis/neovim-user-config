" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Determine OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" disable filetypes in vim-polyglot
let g:polyglot_disabled = ['markdown']

" bash on Windows path
if g:os == "Windows"
    let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH
endif

" set default indentation before sleuth init
set tabstop=2 shiftwidth=2 expandtab

" LOAD PLUGINS
call plug#begin()

" statusline
Plug 'itchyny/lightline.vim'
" lightline-theme
Plug 'andis-spr/lightline-gruvbox-dark.vim'
" VSCode plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" snippets
Plug 'honza/vim-snippets'
" indent indicator line
Plug 'Yggdroot/indentLine'
" general syntax highlighintg
Plug 'sheerun/vim-polyglot'
" commenting
Plug 'tpope/vim-commentary'
" sudo
Plug 'lambdalisue/suda.vim'
" directory browser
Plug 'justinmk/vim-dirvish'
" git general integration
Plug 'tpope/vim-fugitive'
" git indicators in gutter
Plug 'airblade/vim-gitgutter'
" git commit messages under cursor
Plug 'rhysd/git-messenger.vim'
" color scheme
Plug 'lifepillar/vim-gruvbox8'
" git hunks in lightline
Plug 'sinetoami/lightline-hunks'
" buffer cycling and list
Plug 'mihaifm/bufstop'
" fzf integration
if g:os == "Windows" || g:os == "Darwin"
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'
" common *nix actions
Plug 'tpope/vim-eunuch'
" split between single and multiline forms
Plug 'AndrewRadev/splitjoin.vim'
" read editorconfig
Plug 'editorconfig/editorconfig-vim'
" surround chars with chars
Plug 'tpope/vim-surround'
" jump to references and definitions in files
Plug 'pechorin/any-jump.vim'
" generate jsdoc block
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\ }
" detect document indentation
Plug 'tpope/vim-sleuth'
" higlight word under cursor
Plug 'RRethy/vim-illuminate'
" move visual selection
Plug 'Jorengarenar/vim-MvVis'
" more granular word motions
Plug 'chaoren/vim-wordmotion'
" highlight patterns and ranges for Ex commands
Plug 'markonm/traces.vim'

call plug#end()

" coc.nvim extensions
let g:coc_global_extensions = [
  \ "coc-tsserver",
  \ "coc-highlight",
  \ "coc-snippets",
  \ "coc-json",
  \ "coc-eslint", 
  \ "coc-html",
  \ "coc-css",
  \ "coc-clangd"
\ ]

" window title
if g:os == "Windows"
    set title
endif

" leader key
let mapleader="\<space>"

" move over linebreak
nnoremap h <bs>
nnoremap l <space>
vnoremap h <bs>
vnoremap l <space>

" bufstop
let g:BufstopSpeedKeys = ["<F1>", "<F2>", "<F3>", "<F4>", "<F5>", "<F6>"]
let g:BufstopLeader = ""
let g:BufstopAutoSpeedToggle = 1
nnoremap <silent><nowait><leader><leader> :BufstopModeFast<cr>2
nnoremap <silent><nowait><leader>b :BufstopFast<cr>

" disbable default mode indicator
set noshowmode

" enable mouse integration
set mouse=a

" set split directions
set splitbelow
set splitright

" auto equal splits on resize
autocmd VimResized * wincmd =

" floating window transparency
set winblend=10

" resize splits
nnoremap <silent><C-A-j> :resize +2<cr>
nnoremap <silent><C-A-k> :resize -2<cr>
nnoremap <silent><C-A-l> :vertical resize +4<cr>
nnoremap <silent><C-A-h> :vertical resize -4<cr>

" quicker split switching
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" creating splits
nnoremap <silent><leader>s :split<cr>
nnoremap <silent><leader>vs :vsplit<cr>

" close window
nnoremap <C-q> :q<CR>

" lightline setup
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             ['lightline_hunks', 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'filetype' ] ]
  \ },
  \ 'inactive': {
  \   'left': [
  \             ['lightline_hunks', 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ] ,
  \            [ 'filetype' ] ]
  \  },
  \ 'component_function': {
  \  'lightline_hunks': 'lightline#hunks#composer',
  \ }
\ }

let g:lightline.colorscheme = 'gruvboxdark'

" let g:lightline.colorscheme = 'nord'

" jump between git hunks
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

" git status shortcut
nnoremap <silent><nowait><leader>g :Gstatus<cr>

" set default encoding
set encoding=utf-8

" folding
filetype plugin indent on
set foldmethod=syntax
set foldlevel=99

" hidden bufers
set hidden

" no search highlight
set nohlsearch

" higlight line under cursor
"set cursorline

" colors
set termguicolors
set background=dark
colorscheme gruvbox8_hard
syntax on
let g:gitgutter_override_sign_column_highlight = 1

" update gitgutter regurarly
autocmd BufWritePost,WinEnter * GitGutter

" always show signcolumn
set signcolumn=yes:2

" hide empty line indicator
set fcs=eob:\ 

" line numbers
set number
set relativenumber

" command line completion
set wildmenu
set wildmode=longest:list,full

" dispay special chars
"set listchars=eol:⦙,tab:»\ 
set listchars=eol:¶,tab:»\ 
set list

" terminal buffer settings
au TermOpen * setlocal nonumber norelativenumber signcolumn=no

" unfocus terminal
tnoremap <C-w> <C-\><C-n>

" Some servers have issues with backup files
set nobackup
set nowritebackup

" disable swp-ing
set noswapfile

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=100

" No 'Press Enter to continue'
set shortmess+=c

" clipboard system register
set clipboard=unnamedplus

" centered floating window 
function! CreateCenteredFloatingWindow()
  let height = float2nr(&lines * 0.85)
  let top = ((&lines - height) / 2) - 1
  let width = float2nr(&columns - (&columns * 2 / 12))
  let left = float2nr((&columns - width) / 2)
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" sudo
let g:suda_smart_edit = 1

" file exploring
let loaded_netrw = 0

" indent plugin
let g:indentLine_color_gui = '#3c3836'
let g:indentLine_char = '▏'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '▏'
let g:indentLine_fileTypeExclude = ['help', 'terminal']
autocmd TermOpen * IndentLinesDisable

" fzf 
function! ShowGitFiles()
  let gitDirExists = system("git rev-parse --git-dir") == ".git\n"
  if gitDirExists == 1
    execute "GFiles --exclude-standard --others --cached"
  elseif gitDirExists == 0
    execute "Files"
  endif
endfunction

nnoremap <silent><tab> :call ShowGitFiles()<cr>
nnoremap <silent><s-tab> :Files<cr>
nnoremap <silent><leader>e :Rg<cr>

let $FZF_DEFAULT_OPTS = "--tabstop=4 --cycle --no-color --layout=reverse"
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" coc reformatting bindings
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)
xmap <leader>F  <Plug>(coc-format)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Filetypes
au FileType markdown set syntax=off
au FileType markdown.mdx set syntax=off

" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" splitjoin mappings
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap <Leader>k :SplitjoinJoin<cr>
nmap <Leader>j :SplitjoinSplit<cr>

" any-jump
let g:any_jump_disable_default_keybindings = 1
nnoremap <leader>aj :AnyJump<CR>
xnoremap <leader>aj :AnyJumpVisual<CR>
nnoremap <leader>aa :AnyJumpArg 
nnoremap <leader>al :AnyJumpLastResults<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.85
let g:any_jump_window_top_offset   = 3
let g:any_jump_colors = {
  \"plain_text":         "Comment",
  \"preview":            "Comment",
  \"preview_keyword":    "Operator",
  \"heading_text":       "Function",
  \"heading_keyword":    "Identifier",
  \"group_text":         "Comment",
  \"group_name":         "Function",
  \"more_button":        "Operator",
  \"more_explain":       "Comment",
  \"result_line_number": "Comment",
  \"result_text":        "Statement",
  \"result_path":        "String",
  \"help":               "Comment"
  \}

" dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" jsdoc lehre libray location
let g:jsdoc_lehre_path = '~/node_modules/.bin/lehre'
