DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
if [ ! -f $HOME/.config/nvim/coc-settings.json ]; then
ln -s $DIR/coc-settings.json $HOME/.config/nvim/coc-settings.json
fi

if [ ! -f $HOME/.config/nvim/init.vim ]; then
    ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
fi

if [ ! -f $HOME/.local/github.com/repos/github.com/Shougo/dein.vim ]; then
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
    bash /tmp/installer.sh ~/.local/share/nvim/plugged
fi
