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
    "mg979/vim-visual-multi",
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
    { import = "custom.plugins" },
  },
  })

vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })
