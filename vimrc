" Pathogen
" set nocp
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on
filetype plugin indent on

" syntax enable  
" filetype plugin on  
set number  
let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1  

" let g:neocomplete#enable_at_startup = 1

colorscheme molokai

"optional fixes a glitch under some versions of terminal
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif

let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

map <C-n> :NERDTreeToggle<CR>

" ag seach functionality: https://github.com/ggreer/the_silver_searcher
"http://codeinthehole.com/writing/using-the-silver-searcher-with-vim/
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif

" for use of https://github.com/dgryski/vim-godef
let g:godef_split=2

" EasyMotion
 let g:EasyMotion_do_mapping = 0 " Disable default mappings
 map  <Tab> <Plug>(easymotion-bd-f)
 nmap <Tab> <Plug>(easymotion-overwin-f)
 let g:EasyMotion_smartcase = 1

" GoImports
let g:go_fmt_command = "goimports"

"""""""""""""""""""""""""""""""""""""
" Visual Mods

" remove paren matching
:let loaded_matchparen = 1


" Moving lines up/down, http://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

"duplicate lines

function! s:dup_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    let @a = "\n"
    call append(a:n1, @a)

    let linenew = line1    
    call setline(a:n2, linenew)
endfunction

function! s:duplicate()
    let n = line('.')
   
    call s:dup_lines(n, n + 1)
endfunction

"quick remove line function
function! s:remove()
    let n = line('.')
    :exe "normal dd"
endfunction

"fast tab actions
function! s:tabLeft()
    :exe "normal gT"
endfunction

function! s:tabRight()
    :exe "normal gt"
endfunction

function! s:newtab()
    :exe "tabnew"
    :exe "NERDTreeToggle"
endfunction

function! s:closetab()
    :exe "windo bd"
endfunction

"quick remove line function
function! s:openAllGo()
    :argadd **/*.go
    :argadd **/*.md
    :silent! argdelete vendor/*
    :tab all
endfunction

function! s:spellCheck()
    :exe "setlocal spell spelllang=en_us"
endfunction

function! s:spellCheckEnd()
    :exe "set nospell"
endfunction

"""""""""""""""""""""""""""
" mapping keys for custom vim script functions
"""""""""""""""""""""""""""
noremap <silent> <C-left> :call <SID>tabLeft()<CR>
noremap <silent> <C-right> :call <SID>tabRight()<CR>
noremap <A-Left>  :-tabmove<cr>
noremap <A-Right> :+tabmove<cr>

inoremap <C-left> <Esc>  :call <SID>tabLeft()<CR>
inoremap  <C-right> <Esc> :call <SID>tabRight()<CR>

vnoremap  <C-left> <Esc>  :call <SID>tabLeft()<CR>
vnoremap  <C-right> <Esc> `:call <SID>tabRight()<CR>

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
noremap <silent> <C-S-left> :call <SID>remove()<CR>
noremap <silent> <C-S-right> :call <SID>duplicate()<CR>

inoremap <silent> <c-s-up> <Esc>:call <SID>swap_up()<CR>i
inoremap <silent> <c-s-down> <Esc>:call <SID>swap_down()<CR>i
inoremap <silent> <C-S-left> <Esc>:call <SID>remove()<CR>i
inoremap <silent> <C-S-right> <Esc>:call <SID>duplicate()<CR>i

vnoremap <silent> <c-s-up> <Esc>:call <SID>swap_up()<CR>v
vnoremap <silent> <c-s-down> <Esc>:call <SID>swap_down()<CR>v
vnoremap <silent> <C-S-left> <Esc>:call <SID>remove()<CR>v
vnoremap <silent> <C-S-right> <Esc>:call <SID>duplicate()<CR>v

" remap for quick search replace
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor 
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

""" split navigation remap
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"block commanpds
"duplication
nnoremap dup {v}y}p}dd{
"highlight
nnoremap cut {v}xO<Esc>

" remap for gf to open file under cursor, but in a new tab
nnoremap gf <C-W><S-T>gf

" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert
" set 'updatetime' to 15 seconds when in insert mode
" au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
" au InsertLeave * let &updatetime=updaterestore

"""""""""""""""""""""""""""""""""""
" Visual remapping

"remap for left right shifting
vnoremap > xp`[v`]
vnoremap < x2hp`[v`]

"commenting lines or uncommenting lines
vnoremap // :call <SID>addComment()<CR>
vnoremap ?? :call <SID>replaceComment()<CR>

function! s:addComment()
	:s!^\(\S\+\)!//\1!e "if line doesn't start with whitespace
	:s!^\(\s\+\)!\1//!e "if line starts with whitespaces
endfunction

function! s:replaceComment()
    :s!^\(\s\+\)//!\1!e
    :s!^//!!e
endfunction

"""""""""""""""""""""""""""
"" Custom Commands
""""""""""""""""""""""""""
command O call <SID>openAllGo()
command SC call <SID>spellCheck()
command SCE call <SID>spellCheckEnd()
command T call <SID>newtab()
command Q call <SID>closetab()
" Duplication for messed up key strokes
command W :w
command Wq :wq
command WQ :wq

"This next command will force close nerd tree if it's the last and only buffer
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open current line on Github
nnoremap <leader>ou :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs google-chrome<CR><CR>

"quick insert fmt.Println("")
let fmt = "debug %v\\n"
nnoremap fmt Ofmt.Printf("<c-r>=fmt<cr>", )<esc>i
nnoremap F ggVGgq
