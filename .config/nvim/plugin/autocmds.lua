vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Avoid annoying auto-commenting when using o/O on commented line",
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Remember last cursor position",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Force Help pages and Man pages to open in a vertical split",
  pattern = {"help", "man"},
  callback = function ()
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(0) then
        vim.cmd("wincmd L")
      end
    end)
  end
})

vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd ="
})

local resize_timer_id = nil
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Adjust split when resizing windows",
  callback = function()
    if resize_timer_id then
      vim.fn.timer_stop(resize_timer_id)
    end
    resize_timer_id = vim.fn.timer_start(200, function()
      vim.schedule(function()
        vim.cmd("wincmd =")
        resize_timer_id = nil
      end)
    end)
  end,
})
