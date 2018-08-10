# .emacs.d

**Avelino** emacs *personal* configurations.

## Installation

In theory you can just download the .emacs.d directory to your home directory and start Emacs, though if you want to get changes from GitHub, you'll need to do things a bit differently.

```
# hope you know what you're doing
rm -rf ~/.emacs.d ~/.emacs
git clone git://github.com/avelino/.emacs.git ~/.emacs.d
cd ~/.emacs.d
make install
```

*Then just Emacs open, command:* `emacs`

## Configuration

### Working with iTerm2

- Go to System Preferences > Keyboard > Keyboard Shortcuts > Mission Control… and disable all `^-<arrow>` shortcuts
- Go to iTerm2 > Preferences > Profiles > Keys… and set `Left Option` and `Right Option` as `+Esc`
- Click Load Preset… > xterm Defaults

_see more [here](http://offbytwo.com/2012/01/15/emacs-plus-paredit-under-terminal.html) and [here](https://gist.github.com/mguinada/dfd0c7b361d54582508f52b882d27c32)_
