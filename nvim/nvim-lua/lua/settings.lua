-- Mapleader key====================================\
vim.g.mapleader = ","


-- General setup ===================================\

-- Context 
vim.opt.scrolloff 			= 4            ---Min num lines of context
vim.opt.signcolumn 			= "yes"        ---Show the sign column

-- Interface 
vim.opt.syntax 				= "on"         ---Allow syntax highlighting        
vim.opt.colorcolumn 		= '105'        ---Show col for max line length
vim.opt.number 				= true         ---Show line numbers
vim.opt.relativenumber 		= false         ---Show relative line numbers

-- Search 
vim.opt.ignorecase 			= true         ---Ignore case in search patterns
vim.opt.smartcase 			= true         ---Override ignorecase if search contains capitals
vim.opt.incsearch 			= true         ---Use incremental search
vim.opt.hlsearch 			= false        ---Highlight search matches

-- Whitespace
vim.opt.expandtab 			= true         ---Use spaces instead of tabs
vim.opt.shiftwidth 			= 4            ---Size of an indent
vim.opt.softtabstop 		= 4            ---Number of spaces tabs count for in insert mode
vim.opt.tabstop 			= 4            ---Number of spaces tabs count for

-- Splits 
vim.opt.splitright 			= true         ---Place new window to right of current one
vim.opt.splitbelow 			= true         ---Place new window below the current one



-- Themes ==========================================\
vim.opt.termguicolors = true  --If term supports ui color then enable
vim.opt.background = "dark"
vim.cmd([[ colorscheme melange ]])
--vim.g.transparent_enabled = true



-- Plugin Settings =================================\

--autopairs:
require("nvim-autopairs").setup{}

--lualine:
require('lualine').setup {
	options = {
	  icons_enabled = true,
	  theme = 'gruvbox',
	  component_separators = { left = '', right = ''},
	  section_separators = { left = '', right = ''},
  }
}