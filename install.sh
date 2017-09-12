#该脚本在ubuntu 16.04 server可运行.
sudo apt install pylint3 ctags python-dev
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp google_style.pylint.rc ~
cp vimrc ~/.vimrc
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer # 支持C系补全. 经常下载不下来.
