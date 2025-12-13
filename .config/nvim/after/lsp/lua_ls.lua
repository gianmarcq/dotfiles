return {
  on_init = function(client)
    local path = vim.fn.getcwd()
    local nvim_config_path = vim.uv.fs_realpath(vim.fn.stdpath('config'))

    if not nvim_config_path then
      error("Unable to retrieve real path. Cannot load neovim symbols")
      return
    end

    local load_neovim_symbols = (string.find(path, nvim_config_path, 1, true) == 1)
    if load_neovim_symbols then
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = { version = "LuaJIT", },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library", -- wrapper library for networking, filesystem and process management
            -- "${3rd}/busted/library", -- don't know what is this for (prolly test related lib)
          }
        },
        telemetry = { enable = false, },
      })
    end
  end,
}
