set encoding=utf-8 "VIM内部的编码格式.
set nu

" 使用类似于windows下的快捷键.
source $VIMRUNTIME/mswin.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
" 是文件树插件.
Bundle 'scrooloose/nerdtree'
" 代码检查.
Bundle 'vim-syntastic/syntastic'
" 括号自动完成.
Bundle 'Raimondi/delimitMate'
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
"
syntax on
set ts=2
set sw=2

set expandtab
set hlsearch

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" nerdtree配置
set <m-1>=alt-1
map <m-1> :NERDTreeToggle<CR>
" 如果退出时只有nerd tree就自动退出.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" syntastic推荐配置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_exec = '/usr/bin/pylint3'
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args='--rcfile=~/google_style.pylint.rc --disable=C0111,R0903,C0301'
