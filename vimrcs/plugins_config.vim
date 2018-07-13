"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/.vim_runtime/sources_forked/{}')
"call pathogen#infect('~/.vim_runtime/sources_non_forked/{}')
call pathogen#helptags()


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction


call plug#begin('~/.local/share/nvim/plugged')
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'chr4/nginx.vim', {'for': 'nginx'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'python-mode/python-mode', {'branch': 'develop' }
Plug 'tweekmonster/django-plus.vim', {'for': 'python'}
Plug 'pangloss/vim-javascript', {'for': ['javascript.jsx', 'javascript']}
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
Plug 'posva/vim-vue', {'for': ['vue', 'javascript']}
Plug 'morhetz/gruvbox'
Plug 'w0rp/ale'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'dylon/vim-antlr'
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug '~/.vim_runtime/sources_non_forked/YouCompleteMe'
Plug 'jacoborus/tender.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'litao91/mdtree'
Plug 'KeitaNakamura/neodark.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
Plug 'diepm/vim-rest-console'
Plug 'godlygeek/tabular'
Plug 'udalov/kotlin-vim'
Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/neomru.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'kana/vim-fakeclip'
call plug#end()


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>



""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
nmap <c-y> <Plug>yankstack_substitute_older_paste
nmap <c-Y> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <C-e> :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>e :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MD Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pyflakes'],
\   'go': ['gofmt', 'golint', 'go vet', 'go build']
\}


" Custom CoffeeScript SyntasticCheck
func! SyntasticCheckCoffeescript()
    let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
    execute "tabedit " . l:filename
    execute "SyntasticCheck"
    execute "Errors"
endfunc
nnoremap <silent> <leader>c :call SyntasticCheckCoffeescript()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pymode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
" let g:pymode_rope_complete_on_dot = 1
" let g:pymode_rope_completion_bind = '<C-;>'
let g:pymode_rope_completion = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_lint_checkers = ['pep8', 'pylint']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>tt :TagbarToggle<CR>
" let g:tagbar_vertical = 30

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim_runtime/.ycm_extra_conf.py'

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4
nnoremap <leader>] :YcmCompleter GoTo<cr>

let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-markdown-composer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_composer_open_browser = 0
let g:markdown_composer_custom_css = ['file://' . $HOME . "/.vim_runtime/resources/mdstyles/sao-x.css"]
let g:markdown_composer_autostart = 0

let g:vim_markdown_folding_disabled = 1
set conceallevel=0
let g:vim_markdown_math=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-rest-console
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:vrc_response_default_content_type = 'json'
let g:vrc_curl_opts = {
  \ '-L': '',
  \ '-i': '',
  \ '-k': '',
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar markdown support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easy align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Denite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')



call denite#custom#option('default', {
    \ 'prompt': '❯'
    \ })

" call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>',
"     \'noremap')
" call denite#custom#map('normal', '<Esc>', '<NOP>',
"     \'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>',
    \'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
    \'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabswitch>',
    \'noremap')
call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>',
    \'noremap')
call denite#custom#map('normal', 't', '<denite:do_action:tabswitch>',
    \'noremap')

" denite file search (c-p uses gitignore, c-o looks at everything)
map <C-P> :DeniteProjectDir -buffer-name=git -direction=top file_rec/git<CR>
map <C-g> :DeniteProjectDir -buffer-name=files -direction=top file_rec<CR>
map <c-f> :Denite buffer<cr>
map <leader>m :Denite file_mru<cr>

" -u flag to unrestrict (see ag docs)
" call denite#custom#var('file_rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])

call denite#custom#var('file_rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', "--ignore={'*.pyc,.git,*.class,*zip,*.jar,temp_dirs}", '-g', ''])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', "--ignore={'*.pyc,.git,*.class,*zip,*.jar,temp_dirs}", '-g', ''])

" denite content search
map <leader>a :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>

call denite#custom#source(
\ 'grep', 'matchers', ['matcher_regexp'])

" use ag for content search
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
    \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
