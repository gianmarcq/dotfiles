return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', },
  version = '*',
  opts = {
    cmdline = { enabled = false },
    keymap = { preset = 'default', },
    completion = {
      menu = {
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } },
        },
      },

      -- Don't select by default, auto insert on selection
      list = { selection = { preselect = true, auto_insert = false } },
    },
  },
}
