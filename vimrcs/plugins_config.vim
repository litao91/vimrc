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

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.local/share/nvim/plugged/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.local/share/nvim/plugged')
  call dein#begin('~/.local/share/nvim/plugged')
  call dein#add('~/.local/share/nvim/plugged/repos/github.com/Shougo/dein.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('Shougo/defx.nvim', {'hook_post_update': 'UpdateRemotePlugins', 'on_cmd': 'Defx'})
  call dein#add('kristijanhusak/defx-git')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('chr4/nginx.vim', {'on_ft': 'nginx'})
  call dein#add('groenewege/vim-less', {'on_ft': 'less'})
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-expand-region')
  call dein#add('airblade/vim-gitgutter', {'on_cmd': ['GitGutterToggle'])
  call dein#add('itchyny/lightline.vim')
  call dein#add('pangloss/vim-javascript', {'on_ft': ['javascript.jsx', 'javascript']})
  call dein#add('majutsushi/tagbar', {'on_cmd': ['TagbarToggle']})
  call dein#add('Yggdroot/indentLine')
  call dein#add('derekwyatt/vim-scala', {'on_ft': 'scala'})
  call dein#add('dylon/vim-antlr', {'on_ft': ['antlr3', 'antlr4']})
  call dein#add('mxw/vim-jsx', {'on_ft': ['javascript', 'javascript.jsx']})
  call dein#add('litao91/mdtree', {'on_cmd': ['MDTreeToggle'])
  call dein#add('plasticboy/vim-markdown', {'on_ft': ['markdown', 'md']})
  call dein#add('diepm/vim-rest-console', {'on_ft': ['rest'])
  call dein#add('godlygeek/tabular')
  call dein#add('Shougo/denite.nvim', {'hook_post_update': ':UpdateRemotePlugins'})
  call dein#add('easymotion/vim-easymotion')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('Shougo/neomru.vim')
  call dein#add('luochen1990/rainbow')
  call dein#add('neoclide/coc.nvim', {'rec': '*', 'build': 'yarn install'})
  "call dein#add('fenetikm/falcon')
  call dein#add('joshdick/onedark.vim')
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable


let g:rainbow_active = 1
"let g:chromatica#enable_at_startup=1
"let g:chromatica#libclang_path=$HOME . '/.local/lib/libclang.so'

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
"let g:NERDTreeWinPos = "left"
"let NERDTreeShowHidden=0
"let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"let g:NERDTreeWinSize=35
"map <C-e> :NERDTreeToggle<cr>
"map <leader>nb :NERDTreeFromBookmark
"map <leader>e :NERDTreeFind<cr>
"let g:NERDTreeUpdateOnWrite=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Defx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  map <silent> <C-e> :Defx -columns=git:mark:icons:filename:type -split=vertical -winwidth=45 -direction=topleft -toggle `expand('%:p:h')` -search=`expand('%:p')`<cr>
  autocmd FileType defx call s:defx_my_settings()
  function! s:defx_my_settings() abort
    IndentLinesDisable
    setl nospell
    setl signcolumn=no
    call defx#do_action('toggle_ignored_files')    "defx-action-rename
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
    nnoremap <silent><buffer><expr> M defx#do_action('rename')
    nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> P defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> T defx#do_action('drop', [':tabnew'])
    nnoremap <silent><buffer><expr> V defx#do_action('drop', [':vsp'])
    " nnoremap <silent><buffer><expr> C defx#do_action('cd')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> R defx#do_action('redraw')
    setl nonumber
  endfunction
  let g:defx_git#indicators = {
    \ 'Modified'  : '✹',
    \ 'Staged'    : '✚',
    \ 'Untracked' : '✭',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '═',
    \ 'Ignored'   : ' ',
    \ 'Unknown'   : '?',
    \ 'Deleted'   : '✖'
    \ }

  hi def link Defx_filename_directory NERDTreeDirSlash
  hi def link Defx_git_Modified Special
  hi def link Defx_git_Staged Function
  hi def link Defx_git_Renamed Title
  hi def link Defx_git_Unmerged Label
  hi def link Defx_git_Untracked Tag
  hi def link Defx_git_Ignored Comment
  let g:defx_icons_parent_icon = ""

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
let g:ycm_filetype_whitelist = {'c': 1, 'cpp':1}

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
map <C-P> :DeniteProjectDir -buffer-name=git file_rec/git<CR>
map <C-g> :DeniteProjectDir -buffer-name=files file_rec<CR>
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"vmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Shortcuts for denite interface
" Show extension list
nnoremap <silent> <space>e  :<C-u>Denite coc-extension<cr>
" Show symbols of current buffer
nnoremap <silent> <space>o  :<C-u>Denite coc-symbols<cr>
" Search symbols of current workspace
nnoremap <silent> <space>t  :<C-u>Denite coc-workspace<cr>
" Show diagnostics of current workspace
nnoremap <silent> <space>a  :<C-u>Denite coc-diagnostic<cr>
" Show available commands
nnoremap <silent> <space>c  :<C-u>Denite coc-command<cr>
" Show available services
nnoremap <silent> <space>s  :<C-u>Denite coc-service<cr>
" Show links of current buffer
nnoremap <silent> <space>l  :<C-u>Denite coc-link<cr>
