return {
  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require("oil")

      -- Nice header for oil window
      CustomOilBar = function()
        local path = vim.fn.expand("%")
        path = path:gsub("oil://", "")
        path = path:sub(1, -2) .. ':'
        return "   " .. path
      end

      oil.setup {
        columns = { 'mtime', 'size', 'permissions' },
        delete_to_trash = true,
        prompt_save_on_select_new_entry = false,
        skip_confirm_for_simple_edits = true,
        win_options = {
          number = false,
          signcolumn = "yes",
          winbar = "%{v:lua.CustomOilBar()}"
        },
        view_options = {
          is_always_hidden = function(name, _)
            local folder_skip = { "node_modules", ".git" }
            return vim.tbl_contains(folder_skip, name)
          end,
        },
        confirmation = { border = "single" },
        keymaps_help = { border = "single" },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
    end,
  },
}
