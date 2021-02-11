let g:polyglot_disabled = ['c/c++.plugin']

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on':  'NERDTreeToggle' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
"Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
"Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
"Plug 'ap/vim-buftabline'
"Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'tweekmonster/startuptime.vim'

"colorschemes
Plug 'joshdick/onedark.vim'

call plug#end()

" settings
syntax on
filetype plugin indent on
colorscheme onedark
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
set path+=**
set wildmenu
set complete-=i
set smarttab
set incsearch
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set autoread
set updatetime=50
set shortmess+=c
set signcolumn=number
set splitbelow
set splitright
set fileformat=unix


" ignore useless extensions for wildmenu
set wildignore+=*.a,*.o,*.so,*.pyc,.git
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf
set wildignore+=*.tmp,*.swp

" transparent background
hi! Normal ctermbg=NONE guibg=NONE

" vim-autoformat format on save
autocmd BufWrite * :Autoformat
" disable vim-autoformat for conf files
autocmd FileType conf,yaml let b:autoformat_autoindent=0

" coc prettify
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" vim-nerdtree-syntax-highlight highlight full name
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" close NERDTree when closing the last buffer
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files in NERDTree
"let NERDTreeShowHidden=1

let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeMinimalUI = 1

" auto toggle line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" status bar config
"set statusline+=%#warningmsg#

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
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
        call add(msgs, '⛔' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, '⚠ ' . info['warning'])
    endif
    return join(msgs, ' ') . ' |' . get(g:, 'coc_status', '')
endfunction

let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'StatusDiagnostic'
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


" mappings
nnoremap <silent><C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :tabnew <bar> :Startify<CR>

" set space as the leader key
let mapleader = " "

" save file
noremap <silent><leader>w :up<CR>
noremap <silent><C-s> :up<CR>

" refresh
nnoremap <silent><F5> :so%<CR>

" quit
noremap <leader>q :q<CR>
noremap <C-q> :q<CR>

" open last buffer
nnoremap <leader><leader> <C-^>

" easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" change horizontal split to vertical
noremap <leader>th <C-w>t<C-w>K

" change vertical split to horizontal
noremap <leader>tk <C-w>t<C-w>H

" move lines up/down
nnoremap <silent><Esc>j :m .+1<CR>==
nnoremap <silent><Esc>k :m .-2<CR>==
inoremap <silent><Esc>j <Esc>:m .+1<CR>==gi
inoremap <silent><Esc>k <Esc>:m .-2<CR>==gi
vnoremap <silent><Esc>j :m '>+1<CR>gv=gv
vnoremap <silent><Esc>k :m '<-2<CR>gv=gv

" disable arrows
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
endfor

" add new line below current line with Enter in normal mode
nnoremap <CR> o<Esc>k

" switch to normal mode
inoremap kj <Esc>
inoremap jk <Esc>

" disable mouse
set mouse =
set mouse =""


" coc settings
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

" Use <C-space> to trigger completion.
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
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
