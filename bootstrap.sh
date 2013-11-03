for i in ~/.emacs ~/.emacs.d; do [ -e $i ] && mv $i $i.old; done
git clone https://github.com/avelino/.emacs.git ~/.emacs.d
cd ~/.emacs.d/
git submodule init
git submodule update
ln -s ~/.emacs.d/.emacs ~/.emacs
