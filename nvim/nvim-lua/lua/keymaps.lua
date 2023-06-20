local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }

-- Interface
set("n","<Leader>q", ":q<CR>", ns)
set("v","<Leader>q", ":q<CR>", ns)
set("n","<Leader>w", ":wq<CR>", ns)
set("v","<Leader>w", ":wq<CR>", ns)

-- Markdown Preview
set("n", "<Leader>v", ":MarkdownPreview<CR>", ns)
set("n", "<Leader>b", ":MarkdownPreviewToggle", ns)

-- Nerdtree toogle
set("n", "<Leader>o", ":NERDTreeToggle<CR>", ns)


