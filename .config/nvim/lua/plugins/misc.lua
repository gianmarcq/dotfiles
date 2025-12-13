return {
  { "neovim/nvim-lspconfig" },
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
      vim.g.slime_default_config = {socket_name = "default", target_pane = "2"}
      vim.g.slime_dont_ask_default = true
      vim.g.slime_cell_delimiter = "%%"
    end
  },
  {
    "j-hui/fidget.nvim",
    version = "1.6.1",
    opts = {
      notification = {
        window = {
          -- Make notification background color transparent
          winblend = 0
        }
      }
    },
  }
}
