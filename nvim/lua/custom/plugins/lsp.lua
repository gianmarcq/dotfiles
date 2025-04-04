return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          ---@diagnostic disable-next-line: undefined-field
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = { version = 'LuaJIT' },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })

    local opts = { capabilities = capabilities }
    lspconfig.clangd.setup(opts)
    lspconfig.pyright.setup(opts)
    lspconfig.texlab.setup(opts)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        assert(client, "Unable to get client on LspAttach")
        client.server_capabilities.semanticTokensProvider = nil

        vim.diagnostic.config({
          update_in_insert = true,
          virtual_text = true,
          underline = false,
          signs = false
        })
      end,
    })
  end
}
