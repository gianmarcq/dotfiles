-- Reduce startup time
vim.loader.enable()

vim.g.mapleader = " "

-- Evaluate lua code
vim.keymap.set({"n", "v"}, "<leader>x", ":.lua<cr>")

-- Shift lines multiple times
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Shift lines multiple times
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

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
vim.opt.jumpoptions:append({ "stack", "view" })

-- Allow recursive search
vim.opt.path:append("**")

vim.opt.completeopt = { "fuzzy", "menuone", "noinsert", "preview" }

-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})


-- Avoid auto-commenting when writing around comments
vim.api.nvim_create_autocmd("FileType", {
  desc = "Avoid annoying auto-commenting when using o/O on commented line",
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

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

vim.lsp.enable({"clangd"})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.diagnostic.config({
  -- virtual_lines = { current_line = true },
  update_in_insert = false,
  underline = false,
  signs = {
      text = {
          [vim.diagnostic.severity.ERROR] = "e",
          [vim.diagnostic.severity.WARN] = "w",
          [vim.diagnostic.severity.INFO] = "i",
          [vim.diagnostic.severity.HINT] = "h",
      }
  },
})

vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none" })

-- gitsigns
-- telescope
-- oil
-- blink
