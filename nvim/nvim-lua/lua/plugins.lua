local Plug = vim.fn['plug#']
local cmd = vim.cmd

vim.call('plug#begin', '~/.config/nvim/plugged')


---- Themes -----------------------------------------------|
Plug 'morhetz/gruvbox'  
Plug 'savq/melange-nvim' 
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'nvim-lualine/lualine.nvim' 


---- Interface --------------------------------------------|
Plug 'preservim/nerdtree'


---- Tools ------------------------------------------------|
Plug 'iamcco/markdown-preview.nvim' -- "yarn install" in /nvim/plugged/markdown-preview
Plug 'neovim/nvim-lspconfig'
Plug 'windwp/nvim-autopairs'
Plug 'neoclide/coc.nvim' -- "yarn install" in /nvim/plugged/coc-nvim 
Plug 'tpope/vim-fugitive' -- git support
Plug 'sheerun/vim-polyglot'


vim.call('plug#end')

