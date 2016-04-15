" Author: Paul Epperson, 2016                                                  "
" ~/.vimrc: runtime configuration for vim                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on						" Turn on syntax coloring
set nocompatible				" Turn off vi restrictions (redundant)
set noexrc						" Turn off insecure directory exceptions (old)
set nomodeline					" Turn off insecure file exceptions (old)
set showmode					" Turn on current edit mode display (redundant)
set clipboard=unnamedplus		" Turn on system clipboard as vim clipboard
set nowrap						" Turn off line wrapping
set number						" Turn on line numbering
set laststatus=2				" Turn on status permanently
set lazyredraw					" Turn off screen redrawing during macros
set noerrorbells				" Turn off error bells
set novisualbell t_vb=			" Turn off visual bells
set autoindent					" Turn on same-as-previous-line indentation
set cindent						" Turn on indents for C,CPP programs
set smarttab					" Turn on to indent with tabs, align with spaces
set gdefault					" Turn on global search in search
set ignorecase					" Turn off case checking in search
set nohlsearch					" Turn off search highlighting
set incsearch					" Turn on moving to best search before complete
set nojoinspaces				" Turn off spaces after joined sentences
set showcmd						" Turn on last command display
set wildmenu					" Turn on command completion options display
set autoread					" Turn on some file change detections
set fileformats=unix,dos,mac	" Turn on terminator acceptance for common OS's
set backspace=indent,eol,start	" Turn on backspacing over formatting characters
set showmatch					" Turn on view of opening brackets when closed
set scrolloff=999				" Turn on centering cursor when scrolling
set t_Co=256					" Turn on 256 colors in terminal 
set background=light			" Turn on syntax light-background syntax colors
" set filetype plugin indent on	" Turn on formatting from external files

" Remove visual bells on gvim
au GUIEnter * set novisualbell t_vb=

" Highlight past 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#FFD9D9
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,js,rb} match OverLength /\%81v.\+/

" Set/Don't set tab expansion:
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,js,rb} set expandtab
au BufRead,BufNewFile {*.s,Makefile,.gitconfig,.vimrc} set noexpandtab

" Set tab, shift width to 2 (shifts: {<<,>>})
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,js,rb} set shiftwidth=2
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,js,rb} set tabstop=2

" Set tab, shift width to 4
au BufRead,BufNewFile {*.{s,py},Makefile,.gitconfig,.vimrc} set shiftwidth=4
au BufRead,BufNewFile {*.{s,py},Makefile,.gitconfig,.vimrc} set tabstop=4

" Save on focus loss, Reload on focus regained
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" Move between multiple windows
map <C-j> <C-W>j<C-W>
map <C-k> <C-W>k<C-W>
map <C-h> <C-W>h<C-W>
map <C-l> <C-W>l<C-W>

" Foil sudo permissions required to write to file
cmap w!! w !sudo tee > /dev/null %

" Search results appear in middle of screen
nnoremap n nzz
nnoremap N nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Use EGREP-style regular expressions during search/substitutions
:nnoremap / /\v
:cnoremap %s/ %s/\v 

" Toggling between matching objects with % in visual mode selects inclusive text
noremap % v%

" Toggle between matching brackets/parentheses with %, enable % toggle scrolling
autocmd VimEnter * DoMatchParen
inoremap } }<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ] ]<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ) )<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a

" Delete trailing whitespace on save
function! DeleteTrailingWS()
  execute "normal mz"
  %s/\s\+$//ge
  execute "normal `z"
endfunction
autocmd BufWrite * :call DeleteTrailingWS()

" Add spell checking, wrapping, and cursor at beginning for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])    

" Add spell checking toggle via F10 and F11 (gvim)
map <F10> <Esc>:setlocal spell spelllang=en_us<CR>	
map <F11> <Esc>:setlocal nospell<CR>

" Deal with OS file format line endings (globally)
" :%s/\r/+$//e		" Remove ^M/^J from end
" :%s/^\r//e		" Remove ^M/^J from start
" :%s/\r/ /ge		" Replace ^M/^J with space
" :%s/\r/\r/ge		" Replace ^M/^J with line break
" :%s/\r/ /gce		" Replace ^M/^J with space (confirm)
" :%s/\r/\r/gce		" Replace ^M/^J with line break (confirm)

" try
" 	colorscheme solarized
" catch
" endtry
