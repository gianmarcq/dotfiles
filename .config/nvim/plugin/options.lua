vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.guicursor = "i:block"
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 5

-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Proper options for tabs behaviour
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set case insensitiveness
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Make trailing spaces visible
vim.opt.list = true
vim.opt.listchars = { trail = "·" }

-- Preview file substitution
vim.opt.inccommand = "split"

-- Make the jumplist behave like a stack
vim.opt.jumpoptions = { "stack", "view" }
vim.opt.completeopt = { "fuzzy", "menuone", "noinsert", "preview" }

vim.opt.path:append("**")
