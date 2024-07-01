" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"

"""Install Vim-Plug if it is not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
endif

"""Run Pluginstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

"call plug#begin()
call plug#begin('~/.vim/plugged')

"This plugin need vifm to be installed on the system. It isn't standalone
Plug 'vifm/vifm.vim'
Plug 'wikitopian/hardmode'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-scripts/OmniCppComplete'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'

call plug#end()

"Setup for persistent undo in vim
"Guard for distributions lacking the persistnt_undo feature.
if has('persistent_undo')
    "define a path to store persistent_undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')

    "create the directory and ahny parent directiores
    "if the location does not exist
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    "point Vim to the defined undo directory.
    let &undodir = target_path

    "finally, enable undo persistence
    set undofile
endif

"Remmappings for vim-smooth-scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 15, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 15, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 15, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 15, 4)<CR>

"Let leader key be a comma
let mapleader = ','

set cursorcolumn
set cursorline
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
colorscheme slate
" turn off comments automatically carrying on to next line
" This is different from the usual formatoptions to ensure it stays
" after other plugins modify the environment
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" turn line numbers on
set number
" toggle line numbers between relative and absolute depending on text mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

"HighLight Search matches (hls) while search and allow incremental searching while typing (is)
set is
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Michael Pitts <michaelijah@duck.com>"

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/TemplateInclude with F4
map <F3> :e %:p:s,.hxx$,.X123X,:s,.txx$,.hxx,:s,.X123X$,.txx,<CR>
" switch between header/source with F4
map <F4> :e %:p:s,.hxx$,.X123X,:s,.cxx$,.hxx,:s,.X123X$,.cxx,<CR>
" recreate tags file with F5
map <F5> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extras=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :!b<CR>
" build using makeprg with <S-F7>
map <S-F7> :!b clean update<CR>
" goto definition with F12
map <F12> <C-]>
" Jump Back from Definition
map <S-F12> <C-t>
" in diff mode we use the spell check keys for merging
"if &diff
"  ” diff settings
"  map <M-Down> ]c
"  map <M-Up> [c
"  map <M-Left> do
"  map <M-Right> dp
"  map <F9> :new<CR>:read !git diff<CR>:set syntax=diff buftype=nofile<CR>gg
"else
"  " spell settings
"  :setlocal spell spelllang=en
"  " set the spellfile - folders must exist
"  set spellfile=~/.vim/spellfile.add
"  map <M-Down> ]s
"  map <M-Up> [s
"endif

"""""""""""""""""""""""""""
"=> Splits and tabbed files
""""""""""""""""""""""""""
" Make default new windowpane creation to the right and down
set splitbelow splitright

"Remap pane navigation to just CTRL + vim direction 
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Make adjusting split sizes more friendly
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

""""""""""""""""""""
"Remove pipes | that separate on vertical split. There is a space at EOL
set fillchars+=vert:\  

""""""""""""""""""""
"filetype support
""""""""""""""""""""
"c++ template files
autocmd BufEnter *.tpp :setlocal filetype=cpp
autocmd BufEnter *.txx :setlocal filetype=cpp


"""""""""""""""""
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
au BufNewFile,BufRead,BufEnter *.tpp,*.txx,*.cxx,*.cpp,*.hxx,*.hpp set omnifunc=omni#cpp#complete#Main


"The visual alerts to an error without triggering the audible sound, nice
set visualbell
"set vb t_vb=[?5h$<200>[?5l
set vb t_vb=[2m$<200>[22m

"Enable hard mode (disable character wise navigation while learning advanced movement keys)
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
