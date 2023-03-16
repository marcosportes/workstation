" PLUGINS ==============================================================================|
                                  "ref: github.com/junegunn/vim-plug
call plug#begin()


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dense-analysis/ale' " syntax checking and semantic errors
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive' " Git support 
Plug 'yuttie/comfortable-motion.vim' " Smooth scrooling 

" Themes
Plug 'savq/melange'
Plug 'ryanoasis/vim-devicons' " show icon files on nerdtree
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nerdtree
Plug 'preservim/nerdtree' " folders explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " show icons status git on nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " show colors icon syntax on nerdtree

" Auto pairs caracteres
Plug 'jiangmiao/auto-pairs'
if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif





call plug#end()



" GLOBAL SETS ===========================================================================|

syntax on            " Enable syntax highlight
set number           " Enable number on the left
set relativenumber   " Current line is 0
set cursorline       " Show a line in cursor position
set mouse=a          " Enable mouse support
set hidden		     " Hides the current buffer when a new file is opnned
set tabstop=4        " Show existing tab with 4 spaces width
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " Insert tabs on the start of a line according to shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in some cases
set incsearch        " Incremental search
set smartcase        " Consider case if there is a upper case character
set ignorecase       " Ingore case in search
set scrolloff=8      " Minimum number of lines to keep above and below the cursor
set signcolumn=yes   " Add a column on the left. Useful for linting
set colorcolumn=100  " Draws a line at the given line to keep aware of the line size
set cmdheight=2      " Give more space for displaying messages
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set nobackup         " No backup files
set nowritebackup    " No backup files
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any



" THEMES SETS ============================================================================|


set termguicolors "true color
set background=dark
colorscheme melange

" REMAPS ===============================================================================|

nnoremap <C-s> :w! <cr>
nnoremap <C-q> :q! <cr>

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" AUTO CMDS =============================================================================|

" NERDTREE =============================================================================|

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>



" AIRLANE ==============================================================================|

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_soft'








