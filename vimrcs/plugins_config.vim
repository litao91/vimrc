"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.local/share/nvim/plugged/repos/github.com/Shougo/dein.vim

let g:dein#install_process_timeout = 1200

" Required:
if dein#load_state('~/.local/share/nvim/plugged')
  call dein#begin('~/.local/share/nvim/plugged')
  " dein {{{
  call dein#add('~/.local/share/nvim/plugged/repos/github.com/Shougo/dein.vim')
  " }}}
  call dein#add('junegunn/vim-easy-align')
  call dein#add('Shougo/defx.nvim')
  call dein#add('kristijanhusak/defx-git')
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-expand-region')
  " call dein#add('airblade/vim-gitgutter', {'on_cmd': ['GitGutterToggle']})
  call dein#add('itchyny/lightline.vim')
  " call dein#add('majutsushi/tagbar', {'on_cmd': ['TagbarToggle']})
  call dein#add('Yggdroot/indentLine')
  call dein#add('derekwyatt/vim-scala', {'on_ft': 'scala'})
  call dein#add('dylon/vim-antlr', {'on_ft': ['antlr3', 'antlr4']})
  call dein#add('litao91/mdtree', {'on_cmd': ['MDTreeToggle']})
  call dein#add('numirias/semshi')
  " markdown {{{{
  call dein#add('plasticboy/vim-markdown', {'on_ft': ['markdown', 'md']})
  call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
  call dein#add('litao91/clipboard-image.nvim')
  "}}}
  call dein#add('sharat87/roast.vim')
  call dein#add('godlygeek/tabular')
  " denite {{{
  " call dein#add('Shougo/denite.nvim')
  " call dein#add('Shougo/neomru.vim')
  " call dein#add('chemzqm/denite-git')
  " }}}
  call dein#add('liuchengxu/vim-clap')
  " call dein#add('easymotion/vim-easymotion')
  call dein#add('phaazon/hop.nvim')
  " call dein#add('ntpeters/vim-better-whitespace')
  " call dein#add('sheerun/vim-polyglot')
  call dein#add('neoclide/coc.nvim', {'merged':0, 'build': 'yarn install --frozen-lockfile'})
  call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })
  call dein#add('nvim-treesitter/nvim-treesitter-textobjects')
  call dein#add('p00f/nvim-ts-rainbow')

  call dein#add('liuchengxu/vista.vim')
  call dein#add('jackguo380/vim-lsp-cxx-highlight')
  call dein#add('wellle/targets.vim')
  " theme {{{
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('drewtempelmeyer/palenight.vim')
  call dein#add('mhartington/oceanic-next')
  call dein#add('joshdick/onedark.vim')
  call dein#add('arcticicestudio/nord-vim')
  "}}}
  " web {{{
  " call dein#add('groenewege/vim-less', {'on_ft': 'less'})
  call dein#add('TimUntersberger/neogit')
  call dein#add('othree/yajs.vim', {'on_ft': ['javascript.jsx', 'javascript']})
  call dein#add('mxw/vim-jsx', {'on_ft': ['javascript', 'javascript.jsx']})
  " }}}
  "
  call dein#add('skywind3000/asyncrun.vim')
  call dein#add('voldikss/vim-floaterm')
  call dein#add('vim-scripts/cup.vim')
  call dein#add('wfxr/minimap.vim')
  call dein#add('inkarkat/vim-mark')
  call dein#add('inkarkat/vim-ingo-library')
  call dein#add('unblevable/quick-scope')
  call dein#add('psliwka/vim-smoothie')
  call dein#add('tpope/vim-sleuth')


  " call dein#add('datwaft/bubbly.nvim')
  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable


command! PlugClean call map(dein#check_clean(), "delete(v:val, 'rf')")
"command! PlugUpdate call dein#update()

""""""""""""""""""""""""""""""
" => semshi
""""""""""""""""""""""""""""""

let g:semsh#mark_selected_nodes = 0
let g:semshi#error_sign = v:false


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Defx -- faster than nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <Space>z :Defx <cr>

call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'leftabove',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'mark:indent:icon:filename:type'
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '',
      \ })

call defx#custom#column('filename', {
      \ 'directory_icon': '',
      \ 'opened_icon': '',
      \ })

let g:_autoclose_defx = 1
augroup vfinit
  au!
  autocmd FileType defx call s:defx_init()
  " auto close last defx windows
  autocmd BufEnter * nested if
        \ (winnr('$') == 1  && g:_autoclose_defx
        \ && &filetype ==# 'defx') |
        \ call s:close_last_vimfiler_windows() | endif
augroup END

" in this function, we should check if shell terminal still exists,
" then close the terminal job before close vimfiler
function! s:close_last_vimfiler_windows() abort
  q
endfunction
function! s:defx_init()
  setl nonumber
  setl norelativenumber
  setl listchars=
  setl nofoldenable
  setl foldmethod=manual

  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  nnoremap <silent><buffer><expr> '
        \ defx#do_action('toggle_select') . 'j'
  " TODO: we need an action to clear all selections
  nnoremap <silent><buffer><expr> V
        \ defx#do_action('toggle_select_all')
  " nmap <buffer> v       <Plug>(vimfiler_quick_look)
  " nmap <buffer> p       <Plug>(vimfiler_preview_file)
  " nmap <buffer> i       <Plug>(vimfiler_switch_to_history_directory)

  " Define mappings
  nnoremap <silent><buffer><expr> gx
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> H defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> <Left> defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> L defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Right> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> o defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Cr>
        \ defx#is_directory() ?
        \ defx#do_action('open_directory') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> sg
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> st
        \ defx#do_action('drop', 'tabedit')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> yy defx#do_action('call', 'DefxYarkPath')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>  :call cursor(line('$'), 1)<cr>
  nnoremap <silent><buffer><expr> <C-Home>
        \ defx#do_action('cd', SpaceVim#plugins#projectmanager#current_root())
endf
" in this function we should vim-choosewin if possible
function! DefxSmartL(_)
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    let filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        if has('nvim')
          let input = input({
                \ 'prompt'      : 'ChooseWin No.: ',
                \ 'cancelreturn': 0,
                \ })
          if input == 0 | return | endif
        else
          let input = input('ChooseWin No.: ')
        endif
        if input == winnr() | return | endif
        exec input . 'wincmd w'
      endif
      exec 'e' filepath
    else
      exec 'wincmd w'
      exec 'e' filepath
    endif
  endif
endfunction

function! DefxSmartH(_)
  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let sep =  '/'
  if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction

function! DefxYarkPath(_) abort
  let candidate = defx#get_candidate()
  let @+ = candidate['action__path']
  echo 'yarked: ' . @+
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
" => Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-e> :Tree <CR>

try
call tree#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'leftabove',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'mark:indent:git:icon:space:filename:size:time'
      \ })

autocmd FileType tree call s:set_tree()

func! s:set_tree() abort
    nnoremap <silent><buffer><expr> <CR>
                \ tree#is_directory() ?
                \ tree#action('open_directory') : tree#action('drop')
    nnoremap <silent><buffer><expr> H
                \ tree#action('close_tree')
    nnoremap <silent><buffer><expr> U tree#action('cd', ['..'])
    nnoremap <silent><buffer><expr> o tree#action('open_or_close_tree')
    nnoremap <silent><buffer><expr> sg
          \ tree#action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> sv
          \ tree#action('drop', 'split')
    nnoremap <silent><buffer><expr> st
          \ tree#action('drop', 'tabedit')
    nnoremap <silent><buffer><expr> p
        \ tree#action('open', 'pedit')
  nnoremap <silent><buffer><expr> N
        \ tree#action('new_file')
  nnoremap <silent><buffer><expr> r
        \ tree#action('rename')
  nnoremap <silent><buffer><expr> '
        \ tree#action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> d
        \ tree#action('remove')
  nnoremap <silent><buffer><expr> .
        \ tree#action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> yy
        \ tree#action('yank_path')
  nnoremap <silent><buffer><expr> C
        \ tree#action('clear_select_all')
  nnoremap <silent><buffer><expr> V
        \ tree#action('toggle_select_all')
  nnoremap <silent><buffer><expr> <C-r>
        \ tree#action('redraw')
  nnoremap <silent><buffer><expr> B
        \ tree#action('resize', 90)
  nnoremap <silent><buffer><expr> S
        \ tree#action('resize', 30)
  nnoremap <silent><buffer><expr> UG
        \ tree#action('update_git_map', 30)
endf
catch
lua << EOF
vim.o.termguicolors = true
local custom = require 'tree/custom'
custom.option('_', {
  root_marker='[in]:',
  columns='mark:indent:git:icon:space:filename:size:time',
  winwidth=30,
  split='vertical',
  direction='leftabove',
  show_ignored_files=0,
  toggle=true,
  resume=true
})
custom.column('filename', {
  root_marker_highlight='Ignore',
  max_width=60,
})
custom.column('time', {
  format="%d-%M-%Y",
})
custom.column('mark', {
  readonly_icon="X",
  -- selected_icon="*",
})
custom.option('_', {
})
local tree = require('tree')
-- User interface design
-- keymap(keys, action1, action2, ...)  action can be `vim action` or `tree action`
tree.keymap('cp', 'copy')
tree.keymap('m', 'move')
tree.keymap('p', 'paste')
tree.keymap('<CR>', 'drop')
tree.keymap('H', 'close_tree')
tree.keymap('U', {'cd', '..'})
tree.keymap('o', 'open_or_close_tree')
tree.keymap('sg', {'drop', 'vsplit'})
tree.keymap('sv', {'drop', 'split'})
tree.keymap('st', {'drop', 'tabedit'})
tree.keymap('N', 'new_file')
tree.keymap('r', 'rename')
tree.keymap('\'', 'toggle_select', 'j')
tree.keymap('.', 'remove')
tree.keymap('.', 'toggle_ignored_files')
tree.keymap('yy', 'yank_path')
tree.keymap('C', 'clear_select_all')
tree.keymap('V', 'toggle_select_all')
tree.keymap('<C-r>', 'redraw')
tree.keymap('B', {'resize', 90})
tree.keymap('S', {'resize', 30})
tree.keymap('UG', 'update_git_map')
tree.keymap('d', 'remove')
EOF
endtry
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
let g:vista_default_executive = 'coc'
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" Show full path of filename
function! FilenameForLightline()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['readonly', 'filename', 'modified'], ['cocstatus', 'currentfunction']],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex'], ['blame'] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c',
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'filename': 'FilenameForLightline',
      \   'currentfunction': 'NearestMethodOrFunction',
      \   'blame': 'LightlineGitBlame'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>tt :TagbarToggle<CR>
" let g:tagbar_vertical = 30


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

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
" => vim-clap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-P> :Clap files <CR>
map <c-f> :Clap buffers <CR>
map <leader>a :Clap grep2 <CR>
let g:clap_disable_run_rooter = v:true

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => float term
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-t> :FloatermToggle <CR>

let g:floaterm_shell='/bin/zsh'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Denite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:wildignore
"       \ = '*/tmp/*,*.so,*.swp,*.zip,*.class,tags,*.jpg,
"       \*.ttf,*.TTF,*.png,*/target/*,
"       \.git,.svn,.hg,.DS_Store,*.svg,
"       \*.pyc,.git,*.class,*zip,*.jar,temp_dirs'
" 
" fu! Generate_ignore(ignore,tool, ...) abort
"   let ignore = []
"   if a:tool ==# 'ag'
"     for ig in split(a:ignore,',')
"       call add(ignore, '--ignore')
"       call add(ignore, "'" . ig . "'")
"     endfor
"   elseif a:tool ==# 'rg'
"     for ig in split(a:ignore,',')
"       call add(ignore, '-g')
"       if get(a:000, 0, 0) == 1
"         call add(ignore, "'!" . ig . "'")
"       else
"         call add(ignore, '!' . ig)
"       endif
"     endfor
"   endif
"   return ignore
" endf
" " Define mappings
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
"   nnoremap <silent><buffer><expr> <CR>
"   \ denite#do_map('do_action')
"   nnoremap <silent><buffer><expr>v       denite#do_map('do_action', 'vsplitswitch')
"   nnoremap <silent><buffer><expr>s       denite#do_map('do_action', 'splitswitch')
"   "nnoremap <silent><buffer><expr>t       denite#do_map('do_action', 'tabswitch')
"   nnoremap <silent><buffer><expr>t       denite#do_map('do_action', 'tabopen')
"   nnoremap <silent><buffer><expr> d
"   \ denite#do_map('do_action', 'delete')
"   nnoremap <silent><buffer><expr> p
"   \ denite#do_map('do_action', 'preview')
"   nnoremap <silent><buffer><expr> q
"   \ denite#do_map('quit')
"   nnoremap <silent><buffer><expr> ESC
"   \ denite#do_map('quit')
"   nnoremap <silent><buffer><expr> i
"   \ denite#do_map('open_filter_buffer')
"   nnoremap <silent><buffer><expr> <Space>
"   \ denite#do_map('toggle_select').'j'
" endfunction
" let s:menus = {}
" let s:menus.vim = {'description': 'vim runtime.'}
" let s:menus.vim.command_candidates = [
"       \ ['upgrade: dein:deps', 'call dein#update()'],
"       \ ['dein clean', 'call map(dein#check_clean(), "delete(v:val, ''rf'')")']
"       \ ]
" call denite#custom#var('menu', 'menus', s:menus)
" 
" call denite#custom#option('default', {
"     \ 'prompt': '❯',
"     \ 'split': 'floating',
"     \ 'winheight' : 15,
"     \ 'mode' : 'insert',
"     \ 'start_filter' : 1,
"     \ 'quit' : 1,
"     \ 'highlight_matched_char' : 'MoreMsg',
"     \ 'highlight_matched_range' : 'MoreMsg',
"     \ 'direction': 'rightbelow',
"     \ 'statusline' : has('patch-7.4.1154') ? v:false : 0,
"     \ })
" 
" denite file search (c-p uses gitignore, c-o looks at everything)
" Use vim-clap instead
" map <C-P> :DeniteProjectDir file/rec <CR> 
"map <c-f> :Denite buffer<cr>
" map <leader>m :Denite file_mru<cr>


" call denite#custom#var(
"       \ 'buffer',
"       \ 'date_format', '%m-%d-%Y %H:%M:%S')
" 
" if executable('rg')
"   " For ripgrep
"   " Note: It is slower than ag
"   call denite#custom#var('file/rec', 'command',
"         \ ['rg', '--hidden', '--files', '--glob', '!.git', '--glob', '']
"         \ + Generate_ignore(g:wildignore, 'rg')
"         \ )
" elseif executable('ag')
"   " Change file/rec command.
"   call denite#custom#var('file/rec', 'command',
"         \ ['ag' , '--nocolor', '--nogroup', '-g', '']
"         \ + Generate_ignore(g:wildignore, 'ag')
"         \ )
" endif
" 
" " FIND and GREP COMMANDS
" if executable('rg')
"   " Ripgrep command on grep source
"   call denite#custom#var('grep', 'command', ['rg'])
"   call denite#custom#var('grep', 'default_opts',
"         \ ['--vimgrep', '--no-heading'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'final_opts', [])
" 
" elseif  executable('pt')
"   " Pt command on grep source
"   call denite#custom#var('grep', 'command', ['pt'])
"   call denite#custom#var('grep', 'default_opts',
"         \ ['--nogroup', '--nocolor', '--smart-case'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', [])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'final_opts', [])
" elseif executable('ag')
"   call denite#custom#var('grep', 'command', ['ag'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', [])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'final_opts', [])
"   call denite#custom#var('grep', 'default_opts',
"         \ [ '--vimgrep', '--smart-case' ])
" elseif executable('ack')
"   " Ack command
"   call denite#custom#var('grep', 'command', ['ack'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', ['--match'])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'final_opts', [])
"   call denite#custom#var('grep', 'default_opts',
"         \ ['--ackrc', $HOME.'/.config/ackrc', '-H',
"         \ '--nopager', '--nocolor', '--nogroup', '--column'])
" endif
" 
" call denite#custom#alias('source', 'file/rec/git', 'file/rec')
" call denite#custom#var('file/rec/git', 'command',
"       \ ['git', 'ls-files', '-co', '--exclude-standard'])
" 
" 
" call denite#custom#source(
" \ 'grep', 'matchers', ['matcher_regexp'])

" use ag for content search
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', [])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])
" call denite#custom#var('grep', 'default_opts',
"       \ [ '--vimgrep', '--smart-case' ])

" denite content search
" map <leader>a :DeniteProjectDir -default-action=quickfix grep:::!<CR>
" map <leader>a :DeniteProjectDir grep:::!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=number

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

" Use <c-space> to trigger completion.
inoremap <silent><expr>  <c-o> coc#refresh()


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" Remap <C-f> and <C-b> for scroll float windows/popups.
" nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-k>"
" nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-j>"
" inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-k>"
" vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-j>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap <leader>dd <Plug>(coc-diagnostic-info)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Search files
nnoremap <silent> <space>f  :<C-u>CocList files<CR>
" Grep
nnoremap <silent> <space>g  :<C-u>CocList grep<CR>



" Tree-sitter
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"     highlight = {
"         enable = true,                    -- false will disable the whole extension
"         disable = { 'c' },        -- list of language that will be disabled
"     },
"     incremental_selection = {
"         enable = true,
"         disable = { },
"         keymaps = {                       -- mappings for incremental selection (visual mappings)
"           init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
"           node_incremental = "grn",       -- increment to the upper named parent
"           scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
"           node_decremental = "grm",       -- decrement to the previous node
"         }
"     },
"     refactor = {
"       highlight_defintions = {
"         enable = true
"       },
"       smart_rename = {
"         enable = false,
"         smart_rename = "grr"              -- mapping to rename reference under cursor
"       },
"       navigation = {
"         enable = false,
"         goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
"         list_definitions = "gnD"          -- mapping to list all definitions in current file
"       }
"     },
"     ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
" }
" EOF

lua <<EOF
function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if isModuleAvailable('nvim-treesitter.configs') then
    local treesitter = require'nvim-treesitter.configs'

    -- treesitter setup
    treesitter.setup {
      highlight = {
        enable = true,
        disable = { 'c', 'python', 'cpp'},
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = false
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
      node_movement = {
        enable = true,
        keymaps = {
          move_up = "[N",
          move_down = "]N",
          move_left = "[n",
          move_right = "]n",
        }
      },
      ensure_installed = {'c', 'cpp', 'lua', 'rust'}
    }
end
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" PasteImage

lua <<EOF
require'clipboard-image'.setup {
  img_dir = function () return 'docs/media/' .. vim.api.nvim_call_function('expand', {'%:t:r'}) end,
  img_dir_txt = function () return 'media/' .. vim.api.nvim_call_function('expand', {'%:t:r'}) end,
  img_name = function ()
    return '' ..  os.time() * 1000
  end,
  prefix = function () return '![](' end,
  suffix = function () return ')' end
}
EOF

" quick scope

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" hop
nnoremap <silent> <leader><leader>w :HopWord<CR>
nnoremap <silent> <leader><leader>f :HopChar1<CR>
nnoremap <silent> <leader><leader>t :HopChar2<CR>
nnoremap <silent> <leader><leader>l :HopLine<CR>
