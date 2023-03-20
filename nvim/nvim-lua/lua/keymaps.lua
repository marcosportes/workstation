local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }


-- Nerdtree toogle
set("n", "<Leader>o", ":NERDTreeToggle<CR>", ns)