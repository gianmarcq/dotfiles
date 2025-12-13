-- <C-c> not working in block-mode
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- Evaluate lua code
vim.keymap.set({"n", "v"}, "<leader>x", ":.lua<cr>")

-- Shift lines multiple times
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Shift lines multiple times
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')

vim.keymap.set("n", "<leader>s", ":tabfind ", { desc = "Search file and open new TabPage" })

local opts = { silent = true, desc = "Close current TabPage" }
vim.keymap.set("n", "<leader>c", ":tabclose<cr>", opts)

opts.desc = "Switch to first TabPage"
vim.keymap.set("n", "<c-h>", ":1tabnext<cr>", opts)
opts.desc = "Switch to second TabPage"
vim.keymap.set("n", "<c-j>", ":2tabnext<cr>", opts)
opts.desc = "Switch to third TabPage"
vim.keymap.set("n", "<c-k>", ":3tabnext<cr>", opts)
opts.desc = "Switch to fourth TabPage"
vim.keymap.set("n", "<c-l>", ":4tabnext<cr>", opts)
opts.desc = "Switch to fifth TabPage"
vim.keymap.set("n", "<c-;>", ":5tabnext<cr>", opts)

-- Extras:
--   tabo: Close every tab except the current one
--   tabm: Moves tab
