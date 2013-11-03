for i in ~/.emacs ~/.emacs.d; do [ -e $i ] && mv $i $i.old; done
cd ~/
git clone https://github.com/avelino/.emacs.git ~/.emacs.d
ln -s ~/.emacs.d/.emacs ~/.emacs
