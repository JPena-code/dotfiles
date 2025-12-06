set t_Co=256

colorscheme desert

syntax enable

set relativenumber
set autoindent
set tabstop=2
set smartindent
set virtualedit=all

" Use sapce instead of tabs 
set expandtab

" Key unbinding for arrows keys
inoremap <Left> <C-o>:echo "Don't use left h!"<CR>
nnoremap <Left> :echo "Don't use left h!"<CR>
vnoremap <Left> :echo "Don't use left h!"<CR>
cnoremap <Left> :echo "Don't use left h!"<CR>

cnoremap <Right> :echo "Don't use left l!"<CR>
vnoremap <Right> :echo "Don't use left l!"<CR>
nnoremap <Right> :echo "Don't use left l!"<CR>
inoremap <Right> <C-o>:echo "Don't use left l!"<CR>

inoremap <Up> <C-o>:echo "Don't use left k!"<CR>
nnoremap <Up> :echo "Don't use left k!"<CR>
vnoremap <Up> :echo "Don't use left k!"<CR>
cnoremap <Up> :echo "Don't use left k!"<CR>

inoremap <Down> <C-o>:echo "Don't use left k!"<CR>
nnoremap <Down> :echo "Don't use left k!"<CR>
vnoremap <Down> :echo "Don't use left k!"<CR>
cnoremap <Down> :echo "Don't use left k!"<CR>

