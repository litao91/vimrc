try:
    import concurrent.futures as futures
except ImportError:
    try:
        import futures
    except ImportError:
        futures = None

import zipfile
import shutil
import tempfile
import requests

from os import path


# --- Globals ----------------------------------------------
PLUGINS = """
ack.vim https://github.com/mileszs/ack.vim
ag.vim https://github.com/rking/ag.vim
bufexplorer https://github.com/corntrace/bufexplorer
ctrlp.vim https://github.com/ctrlpvim/ctrlp.vim
mayansmoke https://github.com/vim-scripts/mayansmoke
nerdtree https://github.com/scrooloose/nerdtree
nginx-vim-syntax https://github.com/evanmiller/nginx-vim-syntax
open_file_under_cursor.vim https://github.com/amix/open_file_under_cursor.vim
snipmate-snippets https://github.com/scrooloose/snipmate-snippets
tlib https://github.com/vim-scripts/tlib
vim-addon-mw-utils https://github.com/MarcWeber/vim-addon-mw-utils
vim-bundle-mako https://github.com/sophacles/vim-bundle-mako
vim-coffee-script https://github.com/kchmck/vim-coffee-script
vim-colors-solarized https://github.com/altercation/vim-colors-solarized
vim-indent-object https://github.com/michaeljsmith/vim-indent-object
vim-less https://github.com/groenewege/vim-less
vim-markdown https://github.com/tpope/vim-markdown
vim-pyte https://github.com/therubymug/vim-pyte
vim-snipmate https://github.com/garbas/vim-snipmate
vim-snippets https://github.com/honza/vim-snippets
vim-surround https://github.com/tpope/vim-surround
vim-expand-region https://github.com/terryma/vim-expand-region
vim-multiple-cursors https://github.com/terryma/vim-multiple-cursors
vim-fugitive https://github.com/tpope/vim-fugitive
goyo.vim https://github.com/junegunn/goyo.vim
vim-zenroom2 https://github.com/amix/vim-zenroom2
vim-repeat https://github.com/tpope/vim-repeat
vim-commentary https://github.com/tpope/vim-commentary
vim-go https://github.com/fatih/vim-go
vim-gitgutter https://github.com/airblade/vim-gitgutter
vim-flake8 https://github.com/nvie/vim-flake8
vim-pug https://github.com/digitaltoad/vim-pug
vim-yankstack https://github.com/maxbrunsfeld/vim-yankstack
lightline.vim https://github.com/itchyny/lightline.vim
python-mode https://github.com/klen/python-mode
django-plug.vim https://github.com/tweekmonster/django-plus.vim.git
vim-javascript https://github.com/pangloss/vim-javascript
tagbar https://github.com/majutsushi/tagbar
indentLine https://github.com/Yggdroot/indentLine
vim-scala https://github.com/derekwyatt/vim-scala
vim-vue https://github.com/posva/vim-vue
gruvbox https://github.com/morhetz/gruvbox
ale https://github.com/w0rp/ale
lightline-gruvbox https://github.com/shinchu/lightline-gruvbox.vim
vim-javacomplete2 https://github.com/artur-shaik/vim-javacomplete2
denite.nvim https://github.com/Shougo/denite.nvim
antlr.vim https://github.com/dylon/vim-antlr
tern_for_vim https://github.com/ternjs/tern_for_vim
vim-jsx https://github.com/mxw/vim-jsx
vim-easygrep https://github.com/dkprice/vim-easygrep
""".strip()

GITHUB_ZIP = '%s/archive/master.zip'

SOURCE_DIR = path.join(path.dirname(__file__), 'sources_non_forked')


def download_extract_replace(plugin_name, zip_path, temp_dir, source_dir):
    temp_zip_path = path.join(temp_dir, plugin_name)

    # Download and extract file in temp dir
    req = requests.get(zip_path)
    open(temp_zip_path, 'wb').write(req.content)

    zip_f = zipfile.ZipFile(temp_zip_path)
    zip_f.extractall(temp_dir)

    plugin_temp_path = path.join(temp_dir,
                                 path.join(temp_dir, '%s-master' % plugin_name))

    # Remove the current plugin and replace it with the extracted
    plugin_dest_path = path.join(source_dir, plugin_name)

    try:
        shutil.rmtree(plugin_dest_path)
    except OSError:
        pass

    shutil.move(plugin_temp_path, plugin_dest_path)

    print('Updated {0}'.format(plugin_name))


def update(plugin):
    name, github_url = plugin.split(' ')
    zip_path = GITHUB_ZIP % github_url
    download_extract_replace(name, zip_path,
                             temp_directory, SOURCE_DIR)


if __name__ == '__main__':
    temp_directory = tempfile.mkdtemp()

    try:
        if futures:
            with futures.ThreadPoolExecutor(16) as executor:
                executor.map(update, PLUGINS.splitlines())
        else:
            [update(x) for x in PLUGINS.splitlines()]
    finally:
        shutil.rmtree(temp_directory)
