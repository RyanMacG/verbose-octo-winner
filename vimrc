" ============================================================================= Setup =============================================================================
"

" Allow the neovim Python plugin to work inside a virtualenv, by manually
" specifying the path to python2. This variable must be set before any calls to
" `has('python')`.
if has('nvim')
  let s:uname = system('echo -n "$(uname)"')
  if s:uname == 'Linux'
    let g:python_host_prog='/usr/bin/python2.7'
    let g:python3_host_prog='/usr/bin/python3'
  else
    let g:python_host_prog='/usr/local/bin/python'
    let g:python3_host_prog='/usr/local/bin/python3'
  end
  set termguicolors
  set inccommand=nosplit
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set lazyredraw
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamedplus

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" allow dogmatic in insert mode
set cmdheight=2

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader="\<Space>"
set ttimeout
set ttimeoutlen=-1
set ttyfast

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set fdm=syntax
set foldnestmax=10
set nofoldenable

filetype plugin indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.nvim/backups > /dev/null 2>&1
  set undodir=~/.nvim/backups
  set undofile
endif

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

nnoremap <leader>x :bp <BAR> bd #<CR>
nnoremap <leader>ag :Ag <CR>

" ================ Scrolling ========================
set scrolloff=999 " always keep cursor in middle of the screen
set sidescrolloff=15
set sidescroll=1
set mouse= " no mouse scrolling

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.nvim/plugged') " Plugins initialization start {{{
" }}}

" Appearance
" ====================================================================
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'veloce/vim-aldmeris'
Plug 'NLKNguyen/papercolor-theme'
Plug 'gertjanreynaert/cobalt2-vim-theme'
Plug 'jdkanani/vim-material-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
" {{{
  let g:airline_theme='papercolor'
  let g:airline_left_sep  = '▓▒░'
  let g:airline_right_sep = '░▒▓'
  let g:airline_section_z = '%2p%% %2l/%L:%2v'
  let g:airline#extensions#syntastic#enabled = 0
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline_exclude_preview = 1

  " Tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#show_tabs = 0
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#fnamecollapse = 1
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#buffer_min_count = 2

  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
" }}}
Plug 'kshenoy/vim-signature'
" {{{
  let g:SignatureMarkerTextHL = 'Typedef'
  let g:SignatureMap = {
    \ 'Leader'             :  "m",
    \ 'PlaceNextMark'      :  "m,",
    \ 'ToggleMarkAtLine'   :  "m.",
    \ 'PurgeMarksAtLine'   :  "m-",
    \ 'DeleteMark'         :  "dm",
    \ 'PurgeMarks'         :  "m<Space>",
    \ 'PurgeMarkers'       :  "m<BS>",
    \ 'GotoNextLineAlpha'  :  "",
    \ 'GotoPrevLineAlpha'  :  "",
    \ 'GotoNextSpotAlpha'  :  "",
    \ 'GotoPrevSpotAlpha'  :  "",
    \ 'GotoNextLineByPos'  :  "]'",
    \ 'GotoPrevLineByPos'  :  "['",
    \ 'GotoNextSpotByPos'  :  "]`",
    \ 'GotoPrevSpotByPos'  :  "[`",
    \ 'GotoNextMarker'     :  "[+",
    \ 'GotoPrevMarker'     :  "[-",
    \ 'GotoNextMarkerAny'  :  "]=",
    \ 'GotoPrevMarkerAny'  :  "[=",
    \ 'ListLocalMarks'     :  "m/",
    \ 'ListLocalMarkers'   :  "m?"
    \ }
" }}}

Plug 'mhinz/vim-startify'
" {{{
  let g:startify_session_dir = '~/.nvim/session'
  let g:startify_list_order = ['sessions']
  let g:startify_session_persistence = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_change_to_vcs_root = 1
  nnoremap <F12> :Startify<CR>
  autocmd! User Startified setlocal colorcolumn=0
" }}}
Plug 'tpope/vim-sleuth'
Plug 'junegunn/limelight.vim'
" {{{
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 238
  nmap <silent> gl :Limelight!!<CR>
  xmap gl <Plug>(Limelight)
" }}}
Plug 'junegunn/goyo.vim'
" {{{
  nmap <silent> <leader>gg :Goyo<CR>
" }}}
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 't9md/vim-choosewin'
" {{{
  nmap <leader>' <Plug>(choosewin)
  let g:choosewin_blink_on_land = 0
  let g:choosewin_tabline_replace = 0
" }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
" {{{
  let g:multi_cursor_start_key='<F6>'
" }}}

" Sane CTRL-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Completion
" ====================================================================
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " {{{
"   let g:deoplete#enable_at_startup = 1
" " }}}
Plug 'Konfekt/FastFold'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" {{{
  " let g:neosnippet#snippets_directory = '~/.nvim/snippets'
  " let g:neosnippet#data_directory = $HOME . '/.nvim/cache/neosnippet'
  " let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

  nnoremap <leader>se :NeoSnippetEdit -split<CR>
  nnoremap <leader>sc :NeoSnippetClearMarkers<CR>

  imap <expr><TAB> neosnippet#expandable() ?
        \ "\<Plug>(neosnippet_expand)"
        \ : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \ : "\<TAB>"
" }}}

Plug 'majutsushi/tagbar'
" {{{
  nnoremap <silent> <leader>tb :TagbarToggle<CR>
  let g:tagbar_left = 1
" }}}
" File Navigation
" ====================================================================
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>. :Lines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>: :Commands<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>

  " lets make it railsy
  nnoremap <silent> <leader>ja :Files app/assets<CR>
  nnoremap <silent> <leader>jm :Files app/models<CR>
  nnoremap <silent> <leader>jc :Files app/controllers<CR>
  nnoremap <silent> <leader>jv :Files app/views<CR>
  nnoremap <silent> <leader>jh :Files app/helpers<CR>
  nnoremap <silent> <leader>jM :Files app/mailers<CR>
  nnoremap <silent> <leader>jS :Files app/services<CR>
  nnoremap <silent> <leader>jJ :Files app/jobs<CR>
  nnoremap <silent> <leader>jl :Files lib<CR>
  nnoremap <silent> <leader>jp :Files public<CR>
  nnoremap <silent> <leader>js :Files spec<CR>
  nnoremap <silent> <leader>jf :Files fast_spec<CR>
  nnoremap <silent> <leader>jd :Files db<CR>
  nnoremap <silent> <leader>jC :Files config<CR>
  nnoremap <silent> <leader>jV :Files vendor<CR>
  nnoremap <silent> <leader>jF :Files factories<CR>
  nnoremap <silent> <leader>jT :Files test<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction
" }}}
Plug 'Shougo/neomru.vim'
" {{{
  let g:neomru#file_mru_path = $HOME . '/.nvim/cache/neomru/file'
  let g:neomru#directory_mru_path = $HOME . '/.nvim/cache/neomru/directory'
" }}}

function! ConvertRubyHashSyntax()
  execute '%s/:\([^ ]*\)\(\s*\)=>/\1:/g'
endfunction

nnoremap <silent> <leader>sc :call ConvertRubyHashSyntax()<cr>

" Text Navigation
" ====================================================================
Plug 'Lokaltog/vim-easymotion'
" {{{
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_off_screen_search = 0
  nmap ; <Plug>(easymotion-s2)
" }}}
Plug 'rhysd/clever-f.vim'
" {{{
  let g:clever_f_across_no_line = 1
" }}}

" Text Manipulation
" ====================================================================
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
" {{{
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}
Plug 'tomtom/titspriddle/vim-marked'
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
" {{{
  let g:switch_mapping = '\'
" }}}
Plug 'AndrewRadev/sideways.vim'
" {{{
  nnoremap <Leader>< :SidewaysLeft<CR>
  nnoremap <Leader>> :SidewaysRight<CR>
" }}}
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'

Plug 'christoomey/vim-tmux-navigator'

" Text Objects
" ====================================================================
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'nelstrom/vim-textobj-rubyblock'

" Languages
" ====================================================================
Plug 'benekastah/neomake'
" {{{
  let g:neomake_airline = 0
  let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
  let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }

  let g:neomake_ruby_enabled_makers = ['mri']
  let g:neomake_javascript_enabled_makers = ['eslint']

  map <F4> :lopen<CR>
  map <F5> :Neomake<CR>
  autocmd! BufWritePost * Neomake
" }}}
Plug 'Valloric/MatchTagAlways'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-ragtag'
" {{{
  let g:ragtag_global_maps = 1
" }}}
Plug 'vim-ruby/vim-ruby'
Plug 'hwartig/vim-seeing-is-believing'
" {{{
  augroup seeingIsBelievingSettings
    autocmd!

    autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)

    autocmd FileType ruby nmap <buffer> gz <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby xmap <buffer> gz <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby imap <buffer> gz <Plug>(seeing-is-believing-mark)

    autocmd FileType ruby nmap <buffer> gZ <Plug>(seeing-is-believing-run)
  augroup END
" }}}
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-markdown'
"{{{
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby']
"}}}
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-pug'
Plug 'mxw/vim-jsx'
"{{{
  let g:jsx_ext_required = 0
"}}}
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
" Plug 'othree/yajs.vim'
Plug 'nginx.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" {{{
  let g:used_javascript_libs = 'jquery'
" }}}
Plug 'gavocanov/vim-js-indent'
Plug 'ap/vim-css-color'
Plug 'tmux-plugins/vim-tmux'
Plug 'lervag/vimtex'
" {{{
  let g:vimtex_view_method = 'zathura'
  augroup latex
    autocmd!
    autocmd FileType tex nnoremap <buffer><F4> :VimtexView<CR>
    autocmd FileType tex nnoremap <buffer><F5> :VimtexCompile<CR>
    autocmd FileType tex map <silent> <buffer><F8> :call vimtex#latexmk#errors_open(0)<CR>
  augroup END
" }}}
Plug 'rizzatti/dash.vim'
" {{{
  nnoremap <silent> <leader>ds :Dash <CR>
" }}}

" Git
" ====================================================================
Plug 'tpope/vim-fugitive'
" {{{
  " Fix broken syntax highlight in gitcommit files
  " (https://github.com/tpope/vim-git/issues/12)
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  nnoremap <silent> <leader>gE :Gedit<space>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gR :Gread<space>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gW :Gwrite!<CR>
  nnoremap <silent> <leader>gq :Gwq<CR>
  nnoremap <silent> <leader>gQ :Gwq!<CR>

  function! ReviewLastCommit()
    if exists('b:git_dir')
      Gtabedit HEAD^{}
      nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
      echo 'No git a git repository:' expand('%:p')
    endif
  endfunction
  nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

  augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
" }}}
Plug 'gregsexton/gitv'
" {{{
  let g:Gitv_OpenHorizontal = 1
  nnoremap <silent> <leader>gv :Gitv<CR>
" }}}
Plug 'idanarye/vim-merginal'
" {{{
  nnoremap <leader>gm :MerginalToggle<CR>
" }}}
Plug 'airblade/vim-gitgutter'
" {{{
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 200
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  let g:gitgutter_diff_args = '--ignore-space-at-eol'
  nmap <silent> ]h :GitGutterNextHunk<CR>
  nmap <silent> [h :GitGutterPrevHunk<CR>
  nnoremap <silent> <Leader>gu :GitGutterRevertHunk<CR>
  nnoremap <silent> <Leader>gp :GitGutterPreviewHunk<CR><c-w>j
  nnoremap cog :GitGutterToggle<CR>
" }}}
Plug 'esneider/YUNOcommit.vim'
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/migrate/*.rb'
      \ ]
  let g:gutentags_generate_on_missing = 0
  let g:gutentags_generate_on_write = 0
  let g:gutentags_generate_on_new = 0
  nnoremap <leader>gt :GutentagsUpdate!<CR>
" }}}
Plug 'itspriddle/vim-marked'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'janko-m/vim-test'
" {{{
  function! TerminalSplitStrategy(cmd) abort
    tabnew | call termopen(a:cmd) | startinsert
  endfunction
  let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
  let g:test#custom_strategies.terminal_split = function('TerminalSplitStrategy')
  let test#strategy = 'terminal_split'

  nnoremap <silent> <leader>rr :TestFile<CR>
  nnoremap <silent> <leader>rf :TestNearest<CR>
  nnoremap <silent> <leader>rs :TestSuite<CR>
  nnoremap <silent> <leader>ra :TestLast<CR>
  nnoremap <silent> <leader>ro :TestVisit<CR>
" }}}
Plug 'Shougo/junkfile.vim'
" {{{
  nnoremap <leader>jo :JunkfileOpen<CR>
  let g:junkfile#directory = $HOME . '/.nvim/cache/junkfile'
" }}}
Plug 'junegunn/vim-peekaboo'
" {{{
  let g:peekaboo_delay = 400
" }}}
Plug 'mbbill/undotree'
" {{{
  set undofile
  " Auto create undodir if not exists
  let undodir = expand($HOME . '/.nvim/cache/undodir')
  if !isdirectory(undodir)
    call mkdir(undodir, 'p')
  endif
  let &undodir = undodir

  nnoremap <F11> :UndotreeToggle<CR>
" }}}
Plug '907th/vim-auto-save'
" {{{
  nnoremap coa :AutoSaveToggle<CR>
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_events = ['CursorHold']
" }}}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'mrmargolis/dogmatic.vim'
call plug#end() " Plugins initialization finished {{{
" }}}

" Colors and highlightings {{{
" ====================================================================
" colorscheme jellybeans
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
" set background=dark
" let g:gruvbox_contrast_dark='soft'
" let g:gruvbox_invert_signs=1
" colorscheme aldmeris
" let g:aldmeris_termcolors = "tango"
" let g:aldmeris_transparent = 1
colorscheme PaperColor
" colorscheme kalisi

set cursorline     " highlight current line
set colorcolumn=80 " highlight column

" Various columns
highlight! SignColumn ctermbg=233 guibg=#0D0D0D
highlight! FoldColumn ctermbg=233 guibg=#0D0D0D

" NeoMake
highlight! ErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
highlight! WarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11

" Language-specific
highlight! link elixirAtom rubySymbol
" }}}
" Key Mappings " {{{
nnoremap <leader>vi :tabedit $MYVIMRC<CR>

" Toggle quickfix
map <silent> <F8> :copen<CR>

" Quick way to save file
nnoremap <leader>w :w<CR>

" Y behave like D or C
nnoremap Y y$

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select all text
noremap vA ggVG

" Same as normal H/L behavior, but preserves scrolloff
nnoremap H :call JumpWithScrollOff('H')<CR>
nnoremap L :call JumpWithScrollOff('L')<CR>
function! JumpWithScrollOff(key) " {{{
  set scrolloff=0
  execute 'normal! ' . a:key
  set scrolloff=999
endfunction " }}}

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}
nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Same as above, except it opens unite at the end
nnoremap <silent> <Leader>h<Space> :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 1)<CR>
nnoremap <silent> <Leader>l<Space> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 1)<CR>
nnoremap <silent> <Leader>k<Space> :call JumpOrOpenNewSplit('k', ':leftabove split', 1)<CR>
nnoremap <silent> <Leader>j<Space> :call JumpOrOpenNewSplit('j', ':rightbelow split', 1)<CR>

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS>s :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G

" Universal closing behavior
nnoremap <silent> Q :call CloseSplitOrDeleteBuffer()<CR>
nnoremap <silent> Й :call CloseSplitOrDeleteBuffer()<CR>
function! CloseSplitOrDeleteBuffer() " {{{
  if winnr('$') > 1
    wincmd c
  else
    execute 'bdelete'
  endif
endfunction " }}}

" Delete all hidden buffers
nnoremap <silent> <Leader><BS>b :call DeleteHiddenBuffers()<CR>
function! DeleteHiddenBuffers() " {{{
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction " }}}
" }}}

" Jump to the last known cursor position when opening a file
augroup last_cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     execute "normal! g`\"" |
        \ endif
augroup END

" Remove all trailing whitespace in the file, while preserving cursor position
function! RemoveTrailingSpaces()
  let l = line('.')
  let c = col('.')
  " vint: -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
  %s/\s\+$//e
  " vint: +ProhibitCommandWithUnintendedSideEffect +ProhibitCommandRelyOnUser
  call cursor(l, c)
endfunction

nnoremap <silent> <Leader>w :call RemoveTrailingSpaces()<CR>
" Terminal {{{
" ====================================================================
nnoremap <silent> <leader><Enter> :tabnew<CR>:terminal<CR>
nnoremap <leader>o :below 10sp term://$SHELL<cr>i

" Opening splits with terminal in all directions
nnoremap <Leader>h<Enter> :leftabove  vnew<CR>:terminal<CR>
nnoremap <Leader>l<Enter> :rightbelow vnew<CR>:terminal<CR>
nnoremap <Leader>k<Enter> :leftabove  new<CR>:terminal<CR>
nnoremap <Leader>j<Enter> :rightbelow new<CR>:terminal<CR>

tnoremap <F1> <C-\><C-n>
tnoremap <C-\><C-\> <C-\><C-n>:bd!<CR>

function! TerminalInSplit(args)
  botright split
  execute 'terminal' a:args
endfunction

nnoremap <leader><F1> :execute 'terminal ranger ' . expand('%:p:h')<CR>
nnoremap <leader><F2> :terminal ranger<CR>
augroup terminalSettings
  autocmd!
  autocmd FileType ruby nnoremap <leader>\ :call TerminalInSplit('pry')<CR>
augroup END

" Custom Terminal title
let &titlestring= '%F %r %m'
set title
" }}}
" Netrw {{{
" ====================================================================
map <F1> :Explore<CR>
map <F2> :edit .<CR>

let g:netrw_banner = 0 " disable netrw banner with
let g:netrw_hide   = 1 " show not-hidden files by default
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles

function! s:NetrwCustomSettings()
  setlocal nolist
  map <buffer> <F1> :Rexplore<CR>
  map <buffer> <F2> :Rexplore<CR>
  nmap <buffer> l <CR>
  nmap <buffer> h -
  nnoremap <buffer> ~ :edit ~/<CR>
  nnoremap <buffer> <silent> q :Rexplore<CR>
endfunction

augroup enterNetrw
  autocmd!
  autocmd FileType netrw call s:NetrwCustomSettings()
augroup END
" }}}
" Autocommands {{{
" ====================================================================
augroup vimGeneralCallbacks
  autocmd!
  autocmd BufWritePost .vimrc nested source ~/.vimrc
augroup END

augroup fileTypeSpecific
  autocmd!
  " Rabl support
  autocmd BufRead,BufNewFile *.rabl setfiletype ruby
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " JST support
  autocmd BufNewFile,BufRead *.ejs set filetype=jst
  autocmd BufNewFile,BufRead *.jst set filetype=jst
  autocmd BufNewFile,BufRead *.djs set filetype=jst
  autocmd BufNewFile,BufRead *.hamljs set filetype=jst
  autocmd BufNewFile,BufRead *.ect set filetype=jst

  " Gnuplot support
  autocmd BufNewFile,BufRead *.plt set filetype=gnuplot

  autocmd FileType jst set syntax=htmldjango
augroup END

augroup quickFixSettings
  autocmd!
  autocmd FileType qf
        \ nnoremap <buffer> <silent> q :close<CR> |
        \ map <buffer> <silent> <F4> :close<CR> |
        \ map <buffer> <silent> <F8> :close<CR>
augroup END
"}}}
" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}
" Make those debugger statements painfully obvious
au BufEnter * syn match error contained "\<binding.pry\>"
au BufEnter * syn match error contained "\<binding.remote_pry\>"
au BufEnter * syn match error contained "\<byebug\>"
au BufEnter *.rb syn match error contained "\<debugger\>"
highlight Comment gui=italic
highlight Comment cterm=italic
highlight htmlArg gui=italic
highlight htmlArg cterm=italic
