return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets", },
  version = "1.*",
  opts = {
    cmdline = { enabled = false },
    keymap = { preset = "default", },
    completion = {
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },

      -- Don"t select by default, auto insert on selection
      list = { selection = { preselect = true, auto_insert = false } },

      documentation = { auto_show = false },
    },

    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
