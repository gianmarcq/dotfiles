vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.guicursor = "i:block"
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 5

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
vim.opt.wildoptions = { "tagfile", "fuzzy" }
vim.opt.path:append("**")

-- Typst pdf live-preview
vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")
    vim.system({ "zathura", pdf_path })
  end
end, {})
