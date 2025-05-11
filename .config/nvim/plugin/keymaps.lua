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
