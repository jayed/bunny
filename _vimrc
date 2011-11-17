" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker expandtab:
"
"  This is Jay Edwards' .vimrc
"  The layout, organization, and some bits are from Steve Francia.
"  His original is at https://github.com/spf13/spf13-vim/blob/master/.vimrc
"
"  Tons of things have been pulled from Sontek
"  His dotfiles including his vimrc are at https://github.com/dotfiles
"
"  I've been pillaging across the internet for years so there are
"  numerous other people too numerous to remember who have contributed
"  to this.
"
"  I'd particularly like to thank:
"    Tim Pope https://github.com/tpope,
"    Shougo Matsu <Shougo.Matsu@gmail.com>, and
"    thinca https://github.com/thinca
"  for their incredibly useful plugins.
" }

" Environment {
  " Basics {
    set nocompatible
  " }

  " Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
      if has('win32') || has('win64')
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
      endif
  " }

  " Setup Pathogen {
    " The next three lines ensure that the ~/.vim/bundle/ system works
        runtime bundle/pathogen/autoload/pathogen.vim
        call pathogen#infect()
        call pathogen#helptags()
    " }
" }

" General {
    if !has('win32') && !has('win64')
      set term=$TERM                                " Make arrow and other keys work
    endif
    filetype plugin indent on                       " Automatically detect file types.
    syntax on                                       " syntax highlighting
    scriptencoding utf-8

    set autowriteall                                " automatically write a file when _blanking_ a modified buffer
    set ffs=unix,mac,dos                            " Try recognizing dos, unix, and mac line endings
    set grepprg=ack-grep                            " replace the default grep program with ack
    set history=1000                                " Store a ton of history (default is 20)
    set modeline                                    " Respect modelines
    set modelines=5                                 " ...if they're in the first or last 5 lines
    set noautoread                                  " Don't autoread unless I request it
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=block,onemore                   " allow for cursor where there is no actual character
    " Remember cursor position in file
      autocmd BufReadPost * normal `"
    " If file starts with a shebang, make it executable
      au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent execute "!chmod a+x <afile>" | endif | endif
  " Insert completion {
    " XXX Comment these out for neocpmplete?
    " autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " close preview window automatically when we move around
    " autocmd InsertLeave * if pumvisible() == 0|pclose|endif
  " }

  " Abbreviations {
    iabbrev ldis ಠ_ಠ
    iabbrev jay@ jay@meangrape.com
    iabbrev mg/ http://meangrape.com/
    iabbrev px/ http://poxmonger.com/
    " Username and date
    iabbrev xxsig <Esc>:r ![ -n "$SUDO_USER" ] && echo "$SUDO_USER `date '+\%Y\%m\%d'`" \|\| echo "$USER `date '+\%Y\%m\%d'`"<CR>I<BS><Esc>A
  " }

  " set vim directories; see InitializeVimDirectories function {
    set backup                           " enable backups
    set backupskip=/tmp/*,/private/tmp/* " don't backup things in /tmp
    set undofile                         " persist undos across restart

    " I'm unsure the difference between views and sources
    au BufWinLeave * silent! mkview      " make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview    " make vim load view (state) (folds, cursor, etc)
  " }
" }

" Vim UI {
  set backspace=2               " Allow backspacing over autoindent, EOL, and BOL
  set foldenable                " auto fold code
  set foldlevelstart=0          " maximum folding when opening a buffer
  " XXX I need a toggle between indent/99 and source/0
  set foldmethod=indent         " allow us to fold on indent
  " set foldmethod=syntax       " fold at the sourcecold level
  set gdefault                  " the /g flag on :s substitutions by default
  set hlsearch                  " highlight search terms
  set ignorecase                " case insensitive search
  set incsearch                 " find as you type search
  set linebreak                 " don't wrap text in the middle of a word
  set linespace=0               " No extra spaces between rows
  set noerrorbells              " disable bells and blinks part 1
  set nostartofline             " Avoid moving cursor to BOL when jumping around
  set report=0                  " ex mode commands print # of characters changed
  set smartcase                 " case sensitive when UpperCase present
  set scrolljump=5              " lines to scroll when cursor leaves screen
  set scrolloff=3               " minimum lines to keep above and below cursor
  set shortmess+=aoOtTaI        " abbrev. of messages (avoids 'hit enter'; use [+/RO] for status)
  set showmatch                 " show matching brackets/parenthesis
  set showmode                  " display the current mode
  set splitbelow                " open new windows to the bottom & right
  set splitright
  set tabpagemax=15             " only show 15 tabs
  set title                     " show title in terminal title bar
  set vb t_vb=                  " disable bells and blinks part 2
  set whichwrap=b,s,h,l,<,>,[,] " backspace and cursor keys wrap to
  set winminheight=1            " windows can be 1 line high
  au VimResized * exe "normal! \<c-w>="    " Resize splits when the window is resized

  " Wildmode matching {
    set wildmenu                                   " Menu completion in command mode on <Tab>
    set wildmode=full                              " <Tab> cycles between all matching choices.
    " Ignore these files when completing
    set wildignore+=.hg,.git,.svn                  " Version control
    set wildignore+=*.aux,*.out,*.toc              " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
    set wildignore+=*.luac                         " Lua byte code
    set wildignore+=*.o,*.obj                      " compiled object files
    set wildignore+=*.pyc                          " Python byte code
    set wildignore+=*.spl                          " compiled spelling word lists
    set wildignore+=*.sw?                          " Vim swap files
    set wildignore+=*.DS_Store?                    " OSX bullshit
  " }

  " Numbering {
    set number        " don't use relative line numbering
    set numberwidth=1 " use one column for numbers if possible
  " }

  " Cursorline, Ruler, Statusline {
    set cursorline                                      " highlight current line
    hi CursorLine cterm=bold gui=bold                   " highlight bg color of current line

    " see keymap section for toggles
    if exists ("&colorcolumn" )
      " highlight columns 78 and 120 (email and code)
      set colorcolumn=78,120
      hi ColorColumn ctermbg=lightgrey guibg=lightgrey
    endif

    if has('statusline')
      set laststatus=2
      " Broken down into vaguely-easily understood segments
      set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\
      set statusline+=%{fugitive#statusline()}            " Tim Pope's fugitive
      set statusline+=%#warningmsg#
      set statusline+=%{SyntasticStatuslineFlag()}        " Syntastics plugin
      set statusline+=%*
    endif
  " }

  " Whitespace display {
    " displays tabs with :set list & displays when a line runs off-screen
      set list
      set listchars=tab:»·,eol:¶,trail:·,precedes:<,extends:>
      set showbreak=↪

    " HTML/XML files often have tabs; don't display them
      autocmd filetype html,xml set listchars-=tab:»·

    " Zap all trailing whitespace all the time
      autocmd FileWritePre   * :call BrittSpace()
      autocmd FileAppendPre  * :call BrittSpace()
      autocmd FilterWritePre * :call BrittSpace()
      autocmd BufWritePre    * :call BrittSpace()
  " }
" }

" Formatting {
  set autoindent      " always set autoindenting on
  set expandtab       " Use spaces, not tabs, for autoindent/tab key.
  set matchpairs+=<:> " show matching <> (html mainly) as well
  set nowrap          " don't wrap text
  set smartindent     " use smart indent if there is no indent file
  set shiftwidth=2    " an indent level is 2 spaces wide.
  set shiftround      " indent based on multiples of shiftwidth
  set softtabstop=2   " <BS> over an autoindent deletes both spaces.
  set tabstop=2       " <tab> inserts 2 space
" }

" Key (re)Mappings {
  let mapleader = ","
  " let ; be the same as :
    nnoremap ; :
  " ,e brings up my .vimrc
    map <leader>e :sp ~/.vimrc<CR><C-W>_
  " ,E reloads it
    map <silent><leader>E :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

  map <C-j> <C-w>j      " Easier moving in windows ctrl-jklm changes to that split
  map <C-k> <C-w>k
  map <C-l> <C-w>l
  map <C-h> <C-w>h

  imap <C-W> <C-O><C-W> " and lets make these all work in insert mode too

  " Wrapped lines goes down/up to next row, rather than next line
    nnoremap j gj
    nnoremap k gk

  " Cursor column and line toggling {
    map <silent><leader>cl :set cursorline!<CR>
    imap <silent><leader>cl <Esc>:set cursorline!<CR>a
    map <silent><leader>cc :set cursorcolumn!<CR>
    imap <silent><leader>cc <Esc>:set cursorcolumn!<CR>a"
  " }

  " Fixing typos and general stupidity {
    " Write the file when we forget sudo
      cmap w!! w !sudo tee % >/dev/null
    " No more F1 for help. Avoid fat-fingering ESC
      inoremap <F1> <ESC>
      nnoremap <F1> <ESC>
      vnoremap <F1> <ESC>
    " Stupid shift key fixes
      cmap W w
      cmap WQ wq
      cmap wQ wq
      cmap Q q
  " }

  " yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

  " open/close the quickfix window
  " nmap <leader>c :copen<CR>
  " nmap <leader>cc :cclose<CR>

  " open the command history window
    map <leader>h q:<CR>
  " create a line of = the same size as the current line
    nnoremap <leader>= yypVr=
  " comment line
    nmap \com# O# <Esc>68A=<Esc><Home>4<Right>R<Space>
  " set working directory to current file's directory
    nnoremap <leader>. :lcd %:p:h<CR>

  " XXX Check if par exists?
    set formatprg=par\ -w\ 78        " Use par for cleaning up text

  " OS X system copy and paste {
    if has("mac")
    " copy
      vnoremap <silent> <C-X><C-C> : w !pbcopy<CR>
    " cut
      vnoremap <silent> <C-X><C-X> !pbcopy<CR>
    " paste
      noremap <silent> <C-X><C-V> :set paste<CR> :r !pbpaste<CR> :set nopaste<CR>
    endif
  " }

  " Useful arrow keys {
    map <down> :bn<CR>
    map <up> :bp<CR>
    map <left> :tabp<CR>
    map <right> :tabn<CR>
    map <M-left> :tabf<CR>
    map <M-right> :tabl<CR>
  " }

  " Align text {
    nnoremap <leader>Al :left<CR>
    nnoremap <leader>Ac :center<CR>
    nnoremap <leader>Ar :right<CR>
    vnoremap <leader>Al :left<CR>
    vnoremap <leader>Ac :center<CR>
    vnoremap <leader>Ar :right<CR>
  " }

  " Toggles {
    " pastetoggle (sane indentation on pastes)
        set pastetoggle=<F12>
    " toggle spelling & report status
        nnoremap <leader>S :set spell! spell?<CR>
    " toggle number display
        nmap <F2> :set number!<CR>
    " toggle search highlight & report status
        nnoremap <leader><CR> :set hlsearch! hlsearch? <CR>
    " toggle line numbers and whitespace
        nnoremap <leader><space> :set number!<CR>:set list!<CR>
  " }

  " make . more useful
    nmap . .`[
    nmap <M-.> `[<down>.
    vnoremap <silent> . :normal .<CR>
  " don't use vim native regexes
    nnoremap / /\v
    vnoremap / /\v
  " don't outdent hashes
    inoremap # #

  " Folding shortcuts {
    " space toggles folds.
      nnoremap <Space> za
      vnoremap <Space> za

    " Make zO recursively open whatever top level fold we're in, no matter where the
    " cursor happens to be.
      nnoremap zO zCzO
    " Use ,z to "focus" the current fold.
      nnoremap <leader>z zMzvzz
  " }

  " Tab shortcuts {
    " visual tabbing (does not exit Visual mode)
      vnoremap < <gv
      vnoremap > >gv

    " change tab settings
      map <leader>t2 :setlocal shiftwidth=2<CR>
      map <leader>t4 :setlocal shiftwidth=4<CR>
      map <leader>t8 :setlocal shiftwidth=8<CR>
  " }

  " Don't need this with quickrun
  "map <leader>r :w! <bar> !ruby %<CR>

  " XXX Never quite got this working
  " Highlight every other line
  " map <leader>H :set hls<CR>/\\n.*\\n/<CR>

  " Never tested this; from spf13-vim
    " Fix home and end keybindings for screen, particularly on mac
      map [F $
      imap [F $
      map [H g0
      imap [H g0

  " Commandline mappings {
    " Smart mappings on the command line
      cno $c e <C-\>eCurrentFileDir("e")<CR>
      cno $d e ~/Documents/
      cno $h e ~/
      cno $j e ./
      cno $r e ~/repo

  " $q is very useful when browsing on the command line
      cno $q <C-\>eDeleteTillSlash()<CR>
  " }
" }

" GUI stuff {
  if has('gui_running')
    set guioptions-=T            " remove the toolbar
    set lines=40                 " 40 lines of text instead of 24,
    set background=dark
    set colorscheme=vividchalk
  else
    set term=builtin_ansi       " make arrow and other keys work
    set t_Co=256
    set background=light
    color solarized
    let g:solarized=16
  endif
" }

" import local vimrc {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Plugins {
  " Ack {
    nmap <leader>a <Esc>:Ack!
  " }

  " Command-T {
    map <leader>f :CommandT<CR>
  " }

  " DirDiff {
    map <leader>D :DirDiff
     let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.git,.hg,.svn"
  " }

  " EnhCommentify {
    let g:EnhCommentifyUseAltKeys = 'yes'
    vmap <leader>c <Plug>VisualComment
    vmap <leader>C <Plug>VisualDeComment
  " }

  " Gundo {
    map <leader>g :GundoToggle<CR>
  " }

   " Makegreen {
    " Run django test
      map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
  " }

  " Matchit {
    runtime bundles/matchit/plugins/matchit.vim
    map <tab> %
  " }

    " Minibufexpl {
      let g:miniBufExplorerMoreThanOne = 1
      let g:miniBufExplSplitBelow = 0
      let g:miniBufExplCloseOnSelect = 1
    " }

  " Neocomplete {
    " Basic settings {
      set completeopt=menuone,longest,preview                  " don't select first item, follow typing in autocomplete
      set pumheight=6                                          " Keep a small completion window
    " Disable AutoComplPop.
      let g:acp_enableAtStartup                        = 0
    " Use neocomplcache.
      let g:neocomplcache_enable_at_startup            = 1
    " Use smartcase.
      let g:neocomplcache_enable_smart_case            = 1
    " Use camel case completion.
      let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
      let g:neocomplcache_enable_underbar_completion   = 1
    " Set minimum syntax keyword length.
      let g:neocomplcache_min_syntax_length            = 3
      let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'
    " }

    " Define dictionaries {
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
    " }

    " Define keywords {
      if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
      endif
      let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    " }

    " Plugin key-mappings {
    " Almost all of the default keys conflict with my vimrc
      imap <M-k>                <Plug>(neocomplcache_snippets_expand)
      smap <M-k>                <Plug>(neocomplcache_snippets_expand)
      inoremap <expr><M-g>     neocomplcache#undo_completion()
      inoremap <expr><M-p>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
      " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
      " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><M-t> neocomplcache#smart_close_popup()."\<del>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<del>"
        inoremap <expr><M-y>  neocomplcache#close_popup()
        inoremap <expr><M-e>  neocomplcache#cancel_popup()
    " }

    " Enable omni completion {
        autocmd FileType css setlocal omnifunc           = csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc = htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc    = javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc        = pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc           = xmlcomplete#CompleteTags
    " }

    " Enable heavy omni completion {
        if !exists('g:neocomplcache_omni_patterns')
          let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c    = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp  = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
    " }
  " }

  " NERDTree {
    " XXX Need to do if exists everywhere
      if exists(":NERDTree")
        map <leader>n :NERDTreeToggle<CR>
        nmap <leader>nt :NERDTreeFind<CR>
        let NERDTreeIgnore=['\.pyc', '\~$', '\.git', '\.hg', '\.svn', '\.bzr', '\.aux', '\.out', '\.toc', '\.luac', '\.spl', '\sw?', '\.DS_Store?']

        let NERDTreeShowBookmarks = 1
        let NERDTreeChDirMode     = 0
        let NERDTreeQuitOnOpen    = 1
        let NERDTreeShowHidden    = 1
      endif
  " }

  " PEP8 {
      let g:pep8_map='<leader>8'
  " }

  " pyflakes {
    " Don't let pyflakes use the quickfix window
      let g:pyflakes_use_quickfix = 0
  " }

  " pytest {
      if exists(':Pytest')
        nmap <silent><leader>pf <Esc>:Pytest file<CR>
        nmap <silent><leader>pc <Esc>:Pytest class<CR>
        nmap <silent><leader>pm <Esc>:Pytest method<CR>
        nmap <silent><leader>pn <Esc>:Pytest next<CR>
        nmap <silent><leader>pp <Esc>:Pytest previous<CR>
        nmap <silent><leader>pe <Esc>:Pytest error<CR>
      endif
  " }

  " Rope -- rope is a python refactoring plugin{
    if exists(":RopeRename")
      " Jump to the definition of whatever the cursor is on
        map <leader>j :RopeGotoDefinition<CR>

      " Rename whatever the cursor is on (including references to it)
        map <leader>r :RopeRename<CR>
    endif
  " }

  " Session {
    if exists(":SaveSession")
      map :SS :SaveSession
      map :OS :OpenSession
    endif
  " }

  " SLIMV {
    if exists("clojure_loaded")
      au FileType clojure call TurnOnClojureFolding()
      au FileType clojure compiler clj
      au FileType clojure setlocal report=100000

      "let g:slimv_leader = '\'
      let g:slimv_keybindings = 2

      " Fix the eval mapping
      au FileType clojure nmap <buffer> \ee \ed

      " Indent top-level form
      au FileType clojure nmap <buffer> <localleader>= v((((((((((((=%

      " Use a swank command that works, and doesn't require new app windows
      " XXX Don't think this works. Jay.
      au FileType clojure let g:slimv_swank_cmd='!dtach -n /tmp/dvtm-swank.sock -r winch lein swank'

      au BufWinEnter Slimv.REPL.clj setlocal winfixwidth
      au BufNewFile,BufRead Slimv.REPL.clj setlocal nowrap
      au BufWinEnter Slimv.REPL.clj normal! zR
    endif
  " }

  " XXX Using Neocomplete instead
  " SnipMate {
  "  let g:snips_author = "Jay <jay@meangrape.com>"
  " }

  " Tabbar {
    set showtabline=2
    let g:Tb_SplitBelow=0       " put the tabbar at the top
    let g:Tb_MaxSize=0          " auto-resize
    let g:Tb_MoreThanOne=0      " always visible
    let g:Tb_ModSelTarget = 1
  " }

  " Taglist {
    " Toggle the taglist
    map <leader>t :TlistToggle<CR> let tlTokenList = ["FIXME", "TODO", "XXX", "[ACTION]", "ACTION"]

    " Use Exuberant ctag
      let g:Tlist_Ctags_Cmd = "~/bin/ctags"

    " Taglist on the right side
      let g:Tlist_Use_Right_Window = 1

    " Set size of Taglist window
      let g:Tlist_WinWidth = 25

    " Tell Taglist how to speak wiki
      let tlist_vimwiki_settings = 'wiki;h:Headers'
  " }

  " Tasklist {
    " Toggle the tasklist
      map <leader>td <Plug>TaskList
  " }

  " Unite {
    if exists(":Unite")
      map <leader>u  :Unite
    endif
  " }

  " vim-LaTeX {
      let g:tex_flavor='latex'
  " }

  " VimProc {
    " Remap read and bang; no more 'hit enter';
    " commands are run in your vim buffer
      if exists(":VimProcBang")
        nnoremap :! :VimProcBang
        vnoremap :! :VimProcBang
        nnoremap :read! :VimProcRead
        vnoremap :read! :VimProcRead
      endif
  " }

  " VimWiki {
    if exists("loaded_vimwiki")
      let g:vimwiki_list = [{'path': '~/vimwiki',
          \ 'template_path': '~/vimwiki_html/templates',
          \ 'template_default': 'default',
          \ 'template_ext': '.tpl'}]
    endif
  " }
" }

" Filetype specific changes {
    " Javascript {
      au BufRead *.js set makeprg=jslint\ %
    " }

    " Mako/HTML {
      autocmd BufNewFile,BufRead *.mako,*.mak setlocal ft=html
    " }

    " Python, django, twisted, virtualenv {
      au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
      au BufRead *.py compiler nose
      au BufNewFile,BufRead *.tac set ft=python
      au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

      " Load up virtualenv's vimrc if it exist {
        if filereadable($VIRTUAL_ENV . '/.vimrc')
          source $VIRTUAL_ENV/.vimrc
        endif
      " }

      " Add the virtualenv's site-packages to vim path {
" Don't indent this
python << EOF
import os.path
import sys
import vim
if 'VIRTUALENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
      " }
    " }
" }

" Functions {
  " InitializeVimDirectories {
     " set backupdir=~/.vim/tmp/backup/ " backups
     " set directory=~/.vim/tmp/swap/   " swap files
     " set viewdir=~/.vim/views/        " view files
     " set undodir=~/.vim/tmp/undo/     " undo files
    function! InitializeVimDirectories()
      let separator = "."
      let parent    = $HOME
      let prefix    = '.vim/tmp/'
      let dir_list  = {
            \ 'backup': 'backupdir',
            \ 'swap': 'directory',
            \ 'undo': 'undodir',
            \ 'views': 'viewdir'}

      for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
          if !isdirectory(directory)
            call mkdir(directory)
          endif
        endif
        if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
        else
        let directory = substitute(directory, " ", "\\\\ ", "")
        exec "set " . settingname . "=" . directory
        endif
      endfor
    endfunction
    call InitializeVimDirectories()
  " }

  " Remove pretty much all trailing white space everywhere {
    function! BrittSpace()
      %s/\s*$//
      ''
    :endfunction
  " }

  " Cwd {
    func! Cwd()
      let cwd = getcwd()
      return "e " . cwd
    endfunc
  " }

  " DeleteTillSlash  -- used on commandline {
    func! DeleteTillSlash()
      let g:cmd = getcmdline()
      if MySys() == "linux" || MySys() == "mac"
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
      else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
      endif
      if g:cmd == g:cmd_edited
        if MySys() == "linux" || MySys() == "mac"
          let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        else
          let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        endif
      endif
      return g:cmd_edited
    endfunc
  " }

  " CurrentFileDir  {
    func! CurrentFileDir(cmd)
      return a:cmd . " " . expand("%:p:h") . "/"
    endfunc
  " }

     " MyFoldText -- my own function for folding {
     " which doesn't seem to work with this version of vim
     " I've tried it two different ways
     " function MyFoldText()
     " let nucolwidth = &fdc + &number*&numberwidth
     " let winwd = winwidth(0) - nucolwidth - 5
     " let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
     " let prefix = " _______>>> "
     " let fdnfo = prefix . string(v:foldlevel) . " ,          " . string(foldlinecount)
     " let line =  strpart(getline(v:foldstart), 0 , winwd - len(fdnfo))
     " let fillcharcount = winwd - len(line) - len(fdnfo)
     " return line . repeat("            " ,fillcharcount) . fdnfo
     " endfunction
  " }
" }
