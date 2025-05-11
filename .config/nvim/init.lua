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
    { "ellisonleao/gruvbox.nvim",
    lazy = false,
    init = function ()
      require("gruvbox").setup({
        undercurl = false,
        underline = false,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = true,
        },
        strikethrough = false,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = false, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        dim_inactive = false,
        transparent_mode = true,
        overrides = {
          ['@variable'] = { fg = '#eeeeec' },
          ['@constant'] = { fg = '#eeeeec' },
          ['@module'] = { fg = '#eeeeec' },
          ['@function'] = { fg = '#eeeeec' },
          Normal = { fg = '#eeeeec' },
          Operator = { fg = '#eeeeec' },
          Function = { fg = '#eeeeec' },
          Identifier = { fg = '#eeeeec' },
          Special = { fg = '#eeeeec' },
          Delimiter = { fg = '#eeeeec' },
        }
      })
      vim.cmd.colorscheme("gruvbox")
      -- vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })
    end
  },
  { import = "custom.plugins" },
},
})
