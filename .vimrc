call plug#begin('~/.vim/plugged')

"Plug 'Chiel92/vim-autoformat'
Plug 'cdelledonne/vim-cmake'
Plug 'itchyny/lightline.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-slash'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tweekmonster/startuptime.vim'
Plug 'unblevable/quick-scope'
Plug 'sjl/gundo.vim'
" Plug 'shmup/vim-sql-syntax'

"colorschemes
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kaicataldo/material.vim'

call plug#end()

" settings
syntax on
filetype plugin indent on
colorscheme palenight
set background=dark
set number relativenumber
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set noshowmode
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set showcmd
set backspace=indent,eol,start
set cursorline
set nocompatible
set ignorecase
set nohlsearch
set path+=**
set wildmenu
set complete-=i
set smarttab
set incsearch
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set autoread
set updatetime=1000
set shortmess+=c
set splitbelow
set splitright
set fileformat=unix
set timeoutlen=1000 ttimeoutlen=0
set nowrap
set whichwrap+=b,s,<,>,[,]
set clipboard=unnamedplus

if (!has("nvim"))
    set signcolumn=number
endif

" persistent undo
set undodir=~/.vim/undodir
set undofile

" ignore useless extensions for wildmenu
set wildignore+=*.a,*.o,*.so,*.pyc,.git
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf
set wildignore+=*.tmp,*.swp

" disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" transparent background
hi! Normal ctermbg=NONE guibg=NONE

" vim-autoformat format on save
"autocmd BufWrite * :Autoformat
" disable vim-autoformat for conf files
"autocmd FileType conf,yaml,vim,dosini let b:autoformat_autoindent=0

" coc prettify
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" vim-nerdtree-syntax-highlight highlight full name
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" close NERDTree when closing the last buffer
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files in NERDTree
"let NERDTreeShowHidden=1

let NERDTreeMinimalUI = 1

" auto toggle line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" status bar config
"set statusline+=%#warningmsg#

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors") && $TERM != "linux")
        set termguicolors
    endif
endif

" lightline
set laststatus=2

function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'e ' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'w ' . info['warning'])
    endif
    return join(msgs, ' ') . ' |' . get(g:, 'coc_status', '')
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
            \ 'colorscheme': 'palenight',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'StatusDiagnostic',
            \   'currentfunction': 'CocCurrentFunction'
            \ },
            \ 'inactive': {
            \   'left': [ [ 'filename' ] ],
            \   'right': [ [ 'lineinfo' ] ]
            \ },
            \}

" add coc status to lightline
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" c++ enhanced highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1

" startify
let g:startify_files_number = 5
let g:startify_update_oldfiles = 1
" q e i b s v t
let g:startify_bookmarks = [{'c': '~/.vimrc'}, {'h': '~/.bashrc' }, {'p': '~/.profile' }, {'a': '~/.config/alacritty/alacritty.yml' }]

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#s_next = 1

" Change the colors
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

let g:qs_max_chars=150

" which_key
" Map leader to which_key
nnoremap <silent> <space> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <space> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
set timeoutlen=500


" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = [ 'Commentary'                 , 'comment'  ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files'  ]
let g:which_key_map['b'] = [ ':Buffers'                   , 'search buffers'  ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen'  ]
let g:which_key_map['T'] = [ ':Rg'                        , 'search text'  ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right' ]
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen'  ]
let g:which_key_map['<Tab>'] = [ '<C-^>'                  , 'switch last'  ]

nnoremap <silent><space>v :NERDTreeFind<CR>
noremap <silent><space>w :up<CR>
noremap <space>th <C-w>t<C-w>K
noremap <space>tv <C-w>t<C-w>H

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }


" Register which key map
call which_key#register('<Space>', "g:which_key_map")

" goyo
let g:goyo_width=100
function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    hi! Normal ctermbg=NONE guibg=NONE
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    hi! Normal ctermbg=NONE guibg=NONE
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vim-rainbow
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd FileType * RainbowParentheses

" vim-slash
noremap <plug>(slash-after) zz

" mappings
nnoremap <silent><C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :tabnew <bar> :Startify<CR>

" set space as the leader key
let mapleader = " "

" change emmet leader key
let g:user_emmet_leader_key=","

" refresh
nnoremap <silent><F5> :so $MYVIMRC<CR>

" easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move lines up/down
nnoremap <silent><M-j> :m .+1<CR>==
nnoremap <silent><M-k> :m .-2<CR>==
inoremap <silent><M-j> <Esc>:m .+1<CR>==gi
inoremap <silent><M-k> <Esc>:m .-2<CR>==gi
vnoremap <silent><M-j> :m '>+1<CR>gv=gv
vnoremap <silent><M-k> :m '<-2<CR>gv=gv

" disable arrows
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
endfor

" add new line below current line with Enter in normal mode
nnoremap <CR> o<Esc>k

" disable mouse
set mouse =
set mouse =""


" coc settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_leader() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_leader() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-leader> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Scroll hover
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> K coc#float#has_scroll() ? coc#float#scroll(0) : "\K"
    nnoremap <silent><nowait><expr> J coc#float#has_scroll() ? coc#float#scroll(1) : "\J"
    vnoremap <silent><nowait><expr> K coc#float#has_scroll() ? coc#float#scroll(0) : "\K"
    vnoremap <silent><nowait><expr> J coc#float#has_scroll() ? coc#float#scroll(1) : "\J"
endif

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <CR> could be remapped by other vim plugin, try `:verbose imap <cr>`.
if exists('*complete_info')
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
endif

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
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <space>rr <Plug>(coc-rename)

" Project rename word
nnoremap <space>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Formatting selected code.
" xmap <space>f  <Plug>(coc-format-selected)
" nmap <space>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<space>aap` for current paragraph
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <space>qf  <Plug>(coc-fix-current)

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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<CR>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
" Search workleader symbols.
nnoremap <silent><nowait> <space>ss  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:ascii = [
            \ '                                                       ',
            \ '       ██╗  ██╗ █████╗ ███████╗████████╗██╗   ██╗      ',
            \ '       ██║  ██║██╔══██╗██╔════╝╚══██╔══╝╚██╗ ██╔╝      ',
            \ ' █████╗███████║███████║███████╗   ██║    ╚████╔╝█████╗ ',
            \ ' ╚════╝██╔══██║██╔══██║╚════██║   ██║     ╚██╔╝ ╚════╝ ',
            \ '       ██║  ██║██║  ██║███████║   ██║      ██║         ',
            \ '       ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝      ╚═╝         ',
            \ '                                                       ',
            \ ]

let g:startify_padding_left = 9
let g:startify_custom_header =
            \ 'startify#pad(g:ascii)'


let g:sql_type_default = 'sqlserver'
