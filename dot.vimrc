" My .vimrc file. To locate in ~/.vimrc and to be used with the HUGE version
" of Vim

" VUNDLE CONFIGURATION

set nocompatible              " be iMproved, required 
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Comment out YouCompleteMe if in a cluster where you cannot compile it
Plugin 'ycm-core/YouCompleteMe'
Plugin 'benmills/vimux'
Plugin 'greghor/vim-pyShell'
Plugin 'julienr/vim-cellmode'
Plugin 'tpope/vim-surround'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'tomasiser/vim-code-dark'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'vimwiki/vimwiki'
Plugin 'preservim/nerdtree'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" MY OWN STUFF 

" emulate Visual Studio Code colorscheme
colorscheme codedark
"
" Here starts my vimwiki configuration
" vimwiki configuration (may clash with Vundle configuration)
set nocompatible
filetype plugin on
syntax on
"vimwiki configuration so it doesn't conflict with UltiSnips <tab>
nmap <leader><space> <Plug>VimwikiNextLink
nmap <leader>. <Plug>VimwikiPrevLink
" Conflict with the tab in source code: https://github.com/vimwiki/vimwiki/issues/357
let g:vimwiki_table_mappings = 0
" This is so that my vimwiki is hosted in the repos folder
let g:vimwiki_list = [{'path': '~/repos/wiki', 
            \ 'path_html':'~/wiki_html', 
            \ 'syntax':'default', 
            \ 'template_path':'~/repos/wiki',
            \ 'ext':'.wiki',
            \ 'template_default': 'default',
            \ 'template_ext': '.tpl'}]
" The next is so that I can use markdown syntax instead of the original
" vimwiki syntax
"let g:vimwiki_list = [{'path': '~/vimwiki',
"  \ 'syntax': 'markdown', 'ext': '.md'}]
" The next is so that Python and C++ blocks are highlighted
"let wiki = {}
"let wiki.path = '~/my_wiki/'
"let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
" The following is so that I can have multiline list/itemize items
let g:vimwiki_list_ignore_newline = 0
" The following prevents vimwiki to automatically write buffers upon exit
let g:vimwiki_autowriteall = 0
" Recompile HTML upon writing buffer to disk
autocmd FileType vimwiki autocmd BufWritePost <buffer> silent Vimwiki2HTML
" Make blackwhite the default colorscheme for vimwiki
autocmd FileType vimwiki colorscheme blackwhite
" Load the html of the current file in firefox (h for html)
function! OpenThisHTML()
    let path_to_html_folder = expand(g:vimwiki_list[0]['path_html'])
    let full_path_to_wiki_file = expand('%:p')
    let note_name = split(full_path_to_wiki_file, "wiki")[1]
    " The quotes around make sure that firefox receives the full path instead
    " of just the path up to the first parenthesis
    let full_path_to_html_file = "'" . path_to_html_folder . note_name . "html'"
    "The & at the end guarantees that firefox is executed in the background,
    "so Vim goes back to editing instead of hanging while Firefox is open
    execute "!firefox" full_path_to_html_file "&"  
endfunction
" nmap <C-h> :!firefox '%:p:h'/../vimwiki_html/'%:t:r'.html<CR><CR>
" imap <C-h> <Esc>:!firefox '%:p:h'/../vimwiki_html/'%:t:r'.html<CR><CR>
nmap <C-h> :call OpenThisHTML()<CR><CR>
imap <C-h> <Esc>:call OpenThisHTML()<CR><CR>
" This allows bulletpoints to be continued even at deeper bulletpoint levels,
" instead of only at the first level.
setlocal formatoptions=ctnqro
setlocal comments+=n:*,n:#
" Given a note title surrounded by 6 equal signs in the wiki index, this
" creates a link, follows it and copies the title
nmap <space><CR> k:/======<CR>:noh<CR>7lvt=h<CR>^f<space>t]vT[y<CR>ggO=<space><Esc>pa<space>=<CR><CR><Esc>
" Keybindings for going to previous and next day's diary entries. First you
" have to freed <C-Left> and <C-Right> from Putty, which for some reason holds
" them hostage. You can find which sequence corresponds to <C-Left> (for
" instance), in this case by pressing the following combination in insert
" mode: <C-v><C-Left>. Note that <Esc> is represented by ^[ when you do this.
map <Esc>Od <C-Left>
map! <Esc>Od <C-Left>
map <Esc>Oc <C-Right>
map! <Esc>Oc <C-Right>
nmap <C-Left> :VimwikiDiaryPrevDay<CR>
nmap <C-Right> :VimwikiDiaryNextDay<CR>

" Here ends my vimwiki configuration

" so that vim-cellmode sends code from the cell to the right pane
let g:cellmode_tmux_panenumber=1

" map keys to copying in system clipboard, so that you can search stuff for
" instance on Firefox. Note that in order for Vim to be able to copy to system
" clipboard, it must be compiled with the +clipboard. I usually use the binary
" vim-gtk, which can be installed with
" sudo apt install vim-gtk
vmap <C-Y> "+y
map <C-P> "+p

" vim-cellmode mappings
" start ipython shell with <C-s>. Note that for this to work, you need to add stty -ixon to .bashrc
nmap <C-s> :call StartPyShell()<CR>
" run current cell, and leave cursor in current cell
imap <C-g> <Esc>:call RunTmuxPythonCell(1)<CR>
" run current cell, and take cursor outside of current cell. Note that <C-b>
" won't work in a default tmux installation, since <C-b> is the default prefix
imap <C-b> <C-\><C-o>:call RunTmuxPythonCell(0)<CR>

" avoid an annoying beeping sound. Instead, the ``beeping" will be a white
" flash
set visualbell
" highlight searches and change highlight color (the latter needs to be done
" with the command ColorScheme, so that Vim does it after loading the
" colorscheme and doesn't overwrite it)
set hlsearch
au ColorScheme * hi Search cterm=NONE ctermfg=white ctermbg=DarkRed
" IncSearch changes the color for the current match in search and replace with
" confirmation. That way you can distinguish the one you're currently looking
" at from all the others
au ColorScheme * hi IncSearch cterm=NONE ctermfg=white ctermbg=DarkGreen
" remap :noh to <C-n> in normal model. :noh stops highlighting until next
" search
nmap <C-n> :noh<CR>
" This (supposedly) will make that highlight stays on after a search, but not after a
" string substitution
augroup search_be_gone
  autocmd!
  autocmd CmdlineEnter : let s:prev_hlsearch = v:hlsearch
  autocmd CmdlineLeave : if v:hlsearch && !s:prev_hlsearch | call feedkeys(":nohlsearch\<cr>") | endif
augroup END

" Make sure that tabs are expanded to spaces. If you do this all the time
" consistently, you'll avoid errors of mixing tabs and spaces in the same
" python file
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" Minimize the number of types that Vim goes to a weird buffer type (bt) that
" doesn't allow you to write to files when editing over scp
autocmd BufRead scp://* :set bt=
autocmd BufWritePost scp://* :set bt=
"autocmd BufNewFile,BufRead *.py set keywordprg=pydoc
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
set completeopt-=preview  " avoid the annoying preview window, that shows the documentation of whatever function you are autocompleting, and then stays open

" This mouse behaviour is the closest to what I wanted. It only allows to
" sccroll and select cursor position with mouse in normal mode
set mouse=n

set number                     " Show current line number
set relativenumber             " Show relative line numbers
set backspace=indent,eol,start " To make sure that backspace works in every system
syntax on                      " to make sure that syntax is highlighted in every system

" Avoid mouse setting cursor
" noremap <LeftMouse> ma<LeftMouse>`a   
augroup NO_CURSOR_MOVE_ON_FOCUS
  au!
  au FocusLost * let g:oldmouse=&mouse | set mouse=
  au FocusGained * if exists('g:oldmouse') | let &mouse=g:oldmouse | unlet g:oldmouse | endif
augroup END

" Look for tags file (from ctags) in upper directories recursively
set tags=./tags;/

" Allow to open other buffers when current file is unsaved
set hidden

" Make file completion in command mode (e.g. when opening a file in a buffer
" with :e) more similar to Bash completion
set wildmenu
set wildmode=longest,list

" Set updatetime variable so that live views of tex pdfs get updated
" automatically (used by xuhdev/vim-latex-live-preview)
set updatetime=500

" Status line
set statusline=
set statusline +=[%n]\ \ \%*  "buffer number
set statusline+=%<%F          "full filepath
set statusline+=\ %m          "modified flag
set statusline+=%=            "left/right separator
set statusline+=%l/%L         "cursor line/total lines
set statusline+=\ %P          "percent through file
set laststatus=2              " Show statusline for all windows.

" My very simple script and keybinding to iterate over colorschemes upon
" pressing F12
let g:iterable_colorschemes=['codedark', 'morning', 'blackwhite']
let g:current_colorscheme_idx = 0

function! IterateColorscheme()
    let n_colorschemes = len(g:iterable_colorschemes)
    let g:current_colorscheme_idx = ( g:current_colorscheme_idx + 1 ) % n_colorschemes
    let current_colorscheme = g:iterable_colorschemes[g:current_colorscheme_idx]
    execute "colorscheme" current_colorscheme
endfunction

nmap <F12> :call IterateColorscheme()<CR>
imap <F12> <Esc>:call IterateColorscheme()<CR>i


" Vim isn't able to change the cursor color by itself in a colorscheme: 
" this is something that belongs to urxvt. So a little bit of wizardry is needed
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a gray cursor otherwise
  let &t_EI = "\<Esc>]12;gray\x7"
  silent !echo -ne "\033]12;gray\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif

" NERDTree keybindings
nmap <F10> :NERDTree<CR>
imap <F10> <Esc>:NERDTree<CR>i
" When a file is selected, NERDTree quits instead of haning around and taking
" screen space
let g:NERDTreeQuitOnOpen = 1
" If NERDTree is the last and only buffer, then Vim quits
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Netrw keybindings similar to NERDTree
" This hides the annoying netrw banner
let g:netrw_banner = 0
" This makes the listing style tree-like
let g:netrw_liststyle = 3
" This opens the file in the main (previous) Vim window rather than in the
" netrw window
let g:netrw_browse_split = 4
"let g:netrw_altv = 1
" This makes the netrw window size only a quarter of the screen's width
let g:netrw_winsize = 25
" The following makes Netrw be a constant addition to the left margin
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"

" Keybindings for buffers. The first one lists the buffers and waits for input
" to choose one (l for ls). The second one goes to the next buffer (n for next). The third one goes to
" the previous buffer (b for before). The fourth one goes to the opposite
" buffer (h for hash)
nnoremap ,l :ls<cr>:b<space>
nnoremap ,n :bn<CR>
nnoremap ,b :bp<CR>
nnoremap ,h :b#<CR>

" The following quickly opens my .vimrc
nmap <space>v :e $MYVIMRC<CR>


" Make function to change Anki (Latex) to Vimwiki. Note that the e flag mutes
" error signs when the pattern is not found
function! Wikify()
    %s/\[latex\]//ge
    %s/\[\/latex\]//ge
    %s/\\verb//ge
    %s/|/`/ge
    %s/\\item{/- /ge
    %s/\\\\//ge
    %s/``/"/ge
endfunction
