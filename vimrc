" Pathogen for bundling vim plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Set Leader character to comma
let mapleader=","

" Whitespace display Toggling with LEADER+l 
nmap <leader>l :set list!<CR>
" Display characters for TAB and NL in list-mode
set listchars=tab:▸\ ,eol:¬,trail:.

set ignorecase          " Smart case searching on upper characters only
set smartcase           "                   - " -

set hidden              " use hidden buffers
set ai                  " auto indenting
set history=1000        " keep some more lines of history
set title               " show filename in title

set ruler             " show cursor position ...
set nonumber              " ... but not the line number gutter
" Toggling between line numbering modes with LEADER+n
nmap <leader>n :set ruler! number!<CR>

nmap <leader>p :set paste!<CR>

syntax on               " syntax highlighting
set hlsearch            " highlight the last searched term
set incsearch           " incremental highlighting (highlight on type)
set wildmode=list:longest " extended wildcard selection
set scrolloff=3         " helps keeping some context around the caret

" moving swap file to dedicated directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" enable extended matching
runtime macros/matchit.vim

" Speeding up scrolling with Ctrl-e and Ctrl-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

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
