" PLUGINS ==============================================================================|
                                  "ref: github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'dense-analysis/ale' " syntax checking and semantic errors
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive' " Git support 
Plug 'yuttie/comfortable-motion.vim' " Smooth scrooling 

" Themes
Plug 'savq/melange'
Plug 'ryanoasis/vim-devicons' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File explorer
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