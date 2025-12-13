vim.lsp.enable({
  "lua_ls",
  "clangd",
  "tinymist",
  "pyright",
  "taplo"
})

---@diagnostic disable: need-check-nil
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    vim.bo[buf].omnifunc = nil
    -- vim.bo[buf].tagfunc = nil

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil

    local opts = { buffer = buf, noremap = true, silent = true }

    opts.desc = "go to Definition (Source)"
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    opts.desc = "Go to Declaration (Header)"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    if client.name == "clangd" then
      opts.desc = "Switch between Source/Header file"
      vim.keymap.set("n", "gs", ":LspClangdSwitchSourceHeader<cr>", opts)
    elseif client.name == "tinymist" then
      vim.api.nvim_buf_create_user_command(buf, 'OpenPdf', function()
        local filepath = vim.api.nvim_buf_get_name(0)
        if filepath:match("%.typ$") then
          local pdf_path = filepath:gsub("%.typ$", ".pdf")
          vim.system({ "zathura", pdf_path })
        end
      end, { desc = 'Open pdf based on current file name' })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = false,
  signs = false,
})
