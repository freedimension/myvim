let php_folding=1

" Set Leader character to underscore
let mapleader="_"

"""""""""""""""""""
" PLUGIN HANDLING "
" =============== "
"""""""""""""""""""

call pathogen#runtime_append_all_bundles() " Pathogen for bundling vim plugins
call pathogen#helptags()                   " has to be up here

"""""""""""""""""""""""
" WHITESPACE HANDLING "
" =================== "
"""""""""""""""""""""""

" Whitespace display Toggling with LEADER+l 
nmap <leader>l :set list!<CR>

" Display characters for TAB and NL in list-mode
set listchars=tab:▸\ ,eol:¬,trail:.

"""""""""""""
" SEARCHING "
" ========= "
"""""""""""""
set ignorecase          " Smart case searching on upper characters only
set smartcase           "                   - " -
set hlsearch
set incsearch
set wildmode=list:longest " extended wildcard selection
runtime macros/matchit.vim " enable extended matching

"""""""""""""""""""""
" BUFFERS / WINDOWS "
" ================= "
"""""""""""""""""""""
set hidden              " use hidden buffers
set ai                  " auto indenting
set history=1000        " keep some more lines of history
set title               " show filename in title

""""""""""""""""""
" LINE NUMBERING "
" ============== "
""""""""""""""""""
set ruler               " show cursor position ...
set nonumber            " ... but not the line number gutter
" Toggling between line numbering modes with LEADER+n
nmap <leader>n :set ruler! number!<CR>


nmap <leader>p :set paste!<CR>

" Syntax and search highlighting
syntax on

set scrolloff=3         " helps keeping some context around the caret

" moving swap file to dedicated directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp



" Speeding up scrolling with Ctrl-e and Ctrl-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

autocmd FileType php,javascript highlight whitespaceError ctermbg=red ctermfg=yellow term=bold
autocmd FileType php,javascript match whitespaceError /[^\t]\zs\t\+/
autocmd FileType php,javascript 2match whitespaceError /\(foreach\|for\|if\|while\|switch\|\(function [a-zA-Z0-9_]\+\)\)(/

if executable("par")
  set formatprg=par\ -w78
endif

" When editing a file, always jump to the last cursor position
if has("autocmd")
  filetype plugin indent on
  autocmd BufReadPost *
  \ if ! exists("g:leave_my_cursor_position_alone") |
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \ exe "normal g'\"" |
  \ endif |
  \ endif
endif

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
