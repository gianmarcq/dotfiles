-- Reduce startup time
vim.loader.enable()

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = ' '

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      'lervag/vimtex',
      ft = 'tex',
      config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_quickfix_enabled = 0
        vim.g.vimtex_view_forward_search_on_start = 0
      end,
    },
    {
      "jpalardy/vim-slime",
      ft = 'matlab',
      config = function ()
        vim.g.slime_target = "tmux"
        vim.g.slime_default_config = {socket_name = "default", target_pane = "1"}
        vim.g.slime_dont_ask_default = true
        vim.g.slime_cell_delimiter = "%%"
      end
    },
    { import = "plugins" },
  },
  rocks = { enabled = false },
  install = { colorscheme = { "retrobox" } },
})

vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal",     { ctermbg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "@variable",  { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "@constant",  { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "@module",    { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "@function",  { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Normal",     { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Operator",   { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Function",   { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Special",    { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "Delimiter",  { fg = "#ebdbb2" })
