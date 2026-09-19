return {
  { "neovim/nvim-lspconfig" },
  { "j-hui/fidget.nvim",
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
