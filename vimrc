set encoding=utf-8 "VIM内部的编码格式.
set fileencodings=ucs-bom,utf-8,gbk,latin1
set nu rnu
set pastetoggle=<F9> "在复制代码前用来控制换行格式化.

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
Plugin 'scrooloose/nerdtree'
" 代码检查.
Plugin 'vim-syntastic/syntastic'
" 括号自动完成.
Plugin 'Raimondi/delimitMate'
" 状态栏增强, 最好是有光标位置等信息.
Plugin 'vim-airline/vim-airline'
" 自动处理结尾空白符.
Plugin 'ntpeters/vim-better-whitespace'
" 自动补全, 还包括了一堆IDE的特性.
Plugin 'Valloric/YouCompleteMe'
" 模糊查找.
Plugin 'ctrlpvim/ctrlp.vim'
" 自动添加方法注释.
Plugin 'scrooloose/nerdcommenter'
" 大纲式导航
Plugin 'majutsushi/tagbar'
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
autocmd Filetype python setlocal ts=2 sts=2 sw=2
set hlsearch

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" nerdtree配置
map <C-n> :NERDTreeToggle<CR>
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
let g:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args='--rcfile=~/google_style.pylint.rc --disable=C0111,R0903,C0301'

" airline状态栏
let g:airline_powerline_fonts = 1

" vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" YouCompleteMe, 包括快捷键映射.
let g:ycm_python_binary_path = '/usr/bin/python3'
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" 使用F8打开大纲导航
nmap <F8> :TagbarToggle<CR>

" 显示右界线.
set cc=80


"""""""""""""""
"Quickly Run
""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
	exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!time go run %"
    elseif &filetype == 'mkd'
	exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
