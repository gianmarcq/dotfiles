return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function ()
    local telescope = require("telescope");
    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
            mirror = false
          }
        }
      },
      extensions = { fzf = { fuzzy = true } },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin");
    vim.keymap.set("n", "<leader>f", builtin.find_files)
  end
}
