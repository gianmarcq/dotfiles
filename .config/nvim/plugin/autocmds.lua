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

-- Preserve file cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Remember last cursor position",
  group = vim.api.nvim_create_augroup("RememberCursor", { clear = true }),
  callback = function()
    if vim.fn.line('\'"') > 1 and vim.fn.line('\'"') <= vim.fn.line('$')
    then
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd('exe "normal! g\'\\""')
      end
    end
  end,
})

-- Typst pdf live-preview
vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")
    vim.system({ "zathura", pdf_path })
  end
end, {})
