"common----------------------------------------------------
"file
set noswapfile
set nobackup

"view
syntax on
autocmd ColorScheme * highlight Visual ctermfg=202 ctermbg=105
colorscheme molokai
set t_Co=256
set showtabline=2
set number
set hlsearch
set cursorline
set list
set listchars=tab:»-,trail:-,nbsp:%

"edit
set cindent
set tabstop=4
set shiftwidth=4
vnoremap * "zy:let @/ = @z<CR>n

"plugin
filetype plugin on
"tpopeMarkdown
let g:markdown_fenced_languages=['python','bash=sh','vb.net','sql','uml=plantuml']
let g:deoplete#enable_at_startup = 1
"nerdtree-git
let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "✹",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "✖",
	\ "Dirty"     : "✗",
	\ "Clean"     : "✔︎",
	\ 'Ignored'   : '☒',
	\ "Unknown"   : "?"
\ }
"gitgurtter
set updatetime=300
nmap gij <Plug>(GitGutterNextHunk)
nmap gik <Plug>(GitGutterPrevHunk)
nmap giu <Plug>(GitGutterUndoHunk)
nmap gip <Plug>(GitGutterPreviewHunkk)
"vim-lsp
" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')

"lang server
augroup MyLsp
  autocmd!
  " pip install python-language-server
  if executable('pyls')
    " Python用の設定を記載
    " workspace_configで以下の設定を記載
    " - jediの定義ジャンプで一部無効になっている設定を有効化
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'pycodestyle': {'enabled': v:true},
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif

  if executable(expand('~/lsp/KotlinLanguageServer/server-0.1.13/bin/server'))
      au User lsp_setup call lsp#register_server({
          \ 'name': 'KotlinLanguageServer',
          \ 'cmd': {server_info->[
          \     &shell,
          \     &shellcmdflag,
          \     expand('~/lsp/KotlinLanguageServer/server-0.1.13/bin/server')
          \ ]},
          \ 'whitelist': ['kotlin']
          \ })
  endif

  if executable('sourcekit-lsp')
      au User lsp_setup call lsp#register_server({
          \ 'name': 'sourcekit-lsp',
          \ 'cmd': {server_info->['sourcekit-lsp']},
          \ 'whitelist': ['swift'],
          \ })
  endif

  if executable('java') && filereadable(expand('~/lsp/org.eclipse.lsp4xml-0.3.0-uber.jar'))
      au User lsp_setup call lsp#register_server({
          \ 'name': 'lsp4xml',
          \ 'cmd': {server_info->[
          \     'java',
          \     '-noverify',
          \     '-Xmx1G',
          \     '-XX:+UseStringDeduplication',
          \     '-Dfile.encoding=UTF-8',
          \     '-jar',
          \     expand('~/lsp/org.eclipse.lsp4xml-0.3.0-uber.jar')
          \ ]},
          \ 'whitelist': ['xml']
          \ })
  endif
augroup END
" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete   " オムニ補完を有効化
  " LSP用にマッピング
  nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
  nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  nnoremap <buffer> gD :<C-u>LspReferences<CR>
  nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gq :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction
"/common---------------------------------------------------
"wsl-------------------------------------------------------
"previm
let g:previm_open_cmd='google-chrome'

"deoplate-mssql
let g:deoplete#sources#mssql#server='192.168.2.117'
let g:deoplete#sources#mssql#user='sa'
let g:deoplete#sources#mssql#password='40246988'
let g:deoplete#sources#mssql#db='アルク化成'

"for tmux
noremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>
noremap <silent> <Space>p :r !win32yank.exe -o<CR><CR>
