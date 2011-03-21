" Pathogen for bundling vim plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Set Leader character to comma
let mapleader=","

" Whitespace display Toggling with LEADER+l 
nmap <leader>l :set list!<CR>
" Display characters for TAB and NL in list-mode
set listchars=tab:>\	,eol:v

set hidden              " use hidden buffers
set number              " show line numbers
set ai                  " auto indenting
set history=1000        " keep some more lines of history
set ruler               " show the cursor position
syntax on               " syntax highlighting
set hlsearch            " highlight the last searched term
 
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
