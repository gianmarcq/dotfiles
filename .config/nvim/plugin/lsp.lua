vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.lsp.config.luals = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME }
      }
    }
  }
}

vim.lsp.config.clangd = {
    cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--offset-encoding=utf-8",
    },
    root_markers = { ".clangd", "compile_commands.json" },
    filetypes = { "c", "cpp" },
}

vim.lsp.enable({ "luals", "clangd" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    ---@diagnostic disable-next-line: need-check-nil
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = false,
  signs = false,
})
