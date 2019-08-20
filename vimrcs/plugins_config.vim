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
  call dein#add('chr4/nginx.vim', {'on_ft': 'nginx'})
  call dein#add('groenewege/vim-less', {'on_ft': 'less'})
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-expand-region')
  " call dein#add('airblade/vim-gitgutter', {'on_cmd': ['GitGutterToggle']})
  call dein#add('itchyny/lightline.vim')
  call dein#add('majutsushi/tagbar', {'on_cmd': ['TagbarToggle']})
  call dein#add('Yggdroot/indentLine')
  call dein#add('derekwyatt/vim-scala', {'on_ft': 'scala'})
  call dein#add('dylon/vim-antlr', {'on_ft': ['antlr3', 'antlr4']})
  call dein#add('litao91/mdtree', {'on_cmd': ['MDTreeToggle']})
  call dein#add('numirias/semshi')
  " markdown {{{{
  call dein#add('plasticboy/vim-markdown', {'on_ft': ['markdown', 'md']})
  call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
  "}}}
  call dein#add('sharat87/roast.vim')
  call dein#add('godlygeek/tabular')
  " denite {{{
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('chemzqm/denite-git')
  " }}}
  call dein#add('easymotion/vim-easymotion')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('neoclide/coc.nvim', {'build': 'yarn install --frozen-lockfile'})
  call dein#add('jackguo380/vim-lsp-cxx-highlight')
  " theme {{{
  call dein#add('ayu-theme/ayu-vim')
  call dein#add('drewtempelmeyer/palenight.vim')
  call dein#add('mhartington/oceanic-next')
  call dein#add('joshdick/onedark.vim')
  "}}}
  " javascript {{{
  call dein#add('othree/yajs.vim', {'on_ft': ['javascript.jsx', 'javascript']})
  call dein#add('mxw/vim-jsx', {'on_ft': ['javascript', 'javascript.jsx']})
  " }}}
  "
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
" => Rainbow
""""""""""""""""""""""""""""""
let g:rainbow_active = 1

""""""""""""""""""""""""""""""
" => semshi
""""""""""""""""""""""""""""""

let g:semsh#mark_selected_nodes = 0
let g:semshi#error_sign = v:false


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Defx -- faster than nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:SYS = SpaceVim#api#import('system')
map <silent> <C-e> :Defx <cr>

call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'leftabove',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
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
  let sep = s:SYS.isWindows ? '\\' :  '/'
  if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! DefxYarkPath(_) abort
  let candidate = defx#get_candidate()
  let @+ = candidate['action__path']
  echo 'yarked: ' . @+
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
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['readonly', 'filename', 'modified'], ['cocstatus'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'filename': 'FilenameForLightline'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

" Show full path of filename
function! FilenameForLightline()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction



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

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

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
let g:wildignore
      \ = '*/tmp/*,*.so,*.swp,*.zip,*.class,tags,*.jpg,
      \*.ttf,*.TTF,*.png,*/target/*,
      \.git,.svn,.hg,.DS_Store,*.svg,
      \*.pyc,.git,*.class,*zip,*.jar,temp_dirs'

fu! Generate_ignore(ignore,tool, ...) abort
  let ignore = []
  if a:tool ==# 'ag'
    for ig in split(a:ignore,',')
      call add(ignore, '--ignore')
      call add(ignore, "'" . ig . "'")
    endfor
  elseif a:tool ==# 'rg'
    for ig in split(a:ignore,',')
      call add(ignore, '-g')
      if get(a:000, 0, 0) == 1
        call add(ignore, "'!" . ig . "'")
      else
        call add(ignore, '!' . ig)
      endif
    endfor
  endif
  return ignore
endf
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr>v       denite#do_map('do_action', 'vsplitswitch')
  nnoremap <silent><buffer><expr>s       denite#do_map('do_action', 'splitswitch')
  "nnoremap <silent><buffer><expr>t       denite#do_map('do_action', 'tabswitch')
  nnoremap <silent><buffer><expr>t       denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> ESC
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
let s:menus = {}
let s:menus.vim = {'description': 'vim runtime.'}
let s:menus.vim.command_candidates = [
      \ ['upgrade: dein:deps', 'call dein#update()'],
      \ ['dein clean', 'call map(dein#check_clean(), "delete(v:val, ''rf'')")']
      \ ]
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#option('default', {
    \ 'prompt': '❯',
    \ 'split': 'floating'
    \ })

" denite file search (c-p uses gitignore, c-o looks at everything)
map <C-P> :DeniteProjectDir file/rec <CR>
map <c-f> :Denite buffer<cr>
map <leader>m :Denite file_mru<cr>

" -u flag to unrestrict (see ag docs)
" call denite#custom#var('file_rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])
" call denite#custom#var('file/rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', "--ignore={*.pyc,.git,*.class,*zip,*.jar,temp_dirs}", '-g', ''])

call denite#custom#var('file/rec', 'command',
      \ ['ag' , '--nocolor', '--nogroup', '-g', '']
      \ + Generate_ignore(g:wildignore, 'ag')
      \ )


call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])


call denite#custom#source(
\ 'grep', 'matchers', ['matcher_regexp'])

" use ag for content search
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'default_opts',
      \ [ '--vimgrep', '--smart-case' ])

" denite content search
" map <leader>a :DeniteProjectDir -default-action=quickfix grep:::!<CR>
map <leader>a :DeniteProjectDir grep:::!<CR>

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

" Use <c-space> to trigger completion.
inoremap <silent><expr>  <c-o> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

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
  else
    call CocAction('doHover')
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
xmap <leader>aa  <Plug>(coc-codeaction-selected)
nmap <leader>aa  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

nmap <leader>dd <Plug>(coc-diagnostic-info)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
