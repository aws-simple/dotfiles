" see https://www.manniwood.com/2016_04_09/vimrc.html
" see https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/

filetype on
filetype plugin on

autocmd FileType go setlocal list
autocmd FileType go setlocal listchars=eol:·,tab:·\ 
autocmd FileType go setlocal shiftwidth=4
autocmd FileType go setlocal tabstop=4
