return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", },
  version = "1.*",
  opts = {
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },

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
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
