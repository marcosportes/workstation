local Plug = vim.fn['plug#']
local cmd = vim.cmd


vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim'
Plug 'savq/melange-nvim' -- theme
Plug 'tpope/vim-fugitive' -- git support
Plug 'nvim-lualine/lualine.nvim' -- line theme
Plug 'kyazdani42/nvim-web-devicons' -- icons
Plug 'sheerun/vim-polyglot'
Plug 'windwp/nvim-autopairs'
Plug 'fatih/vim-go' -- golang support

vim.call('plug#end')