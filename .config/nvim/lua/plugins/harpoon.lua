return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  end
}
