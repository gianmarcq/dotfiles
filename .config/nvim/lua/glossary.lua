local DEBUG = false

local function dprint(msg)
  if DEBUG then
    vim.notify(msg, vim.log.levels.INFO)
  end
end

local function get_api_key()
    local ok, secrets = pcall(require, "secrets")
    if ok and secrets.deepl_api_key then
        return secrets.deepl_api_key
    end
    return nil
end


local CONFIG = {
  auth_key = get_api_key() or error("DEEPL_API_KEY environment variable required"),
  target_lang = "IT",
  source_lang = "EN"
}

local curl = require("plenary.curl")

-- async translation via plenary.curl
local function async_translate(text, callback)
  curl.post("https://api-free.deepl.com/v2/translate", {
    body = {
      auth_key = CONFIG.auth_key,
      text = text,
      target_lang = CONFIG.target_lang,
      source_lang = CONFIG.source_lang,
      formality = "less",
    },
    callback = function(res)
      if res and res.status == 200 then
        local ok, json = pcall(vim.json.decode, res.body)
        if ok and json and json.translations and json.translations[1] then
          vim.schedule(function()
            callback(json.translations[1].text)
          end)
          return
        end
      end
      -- fallback if translation fails
      vim.schedule(function()
        callback(text)
      end)
    end,
  })
end

local function split_into_tokens(line)
  local parts = vim.split(line, ":", { plain = true, trimempty = false })
  for i, token in ipairs(parts) do
    parts[i] = vim.trim(token)
  end
  return parts
end

local function init_cache(bufnr)
  local cache = {}
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for _, line in ipairs(lines) do
    local tks = split_into_tokens(line)
    local tkslen = #tks
    if tkslen == 2 then
      local unk, tran = tks[1], tks[2]
      if unk ~= "" and tran ~= "" then
        cache[unk] = tran
      end
    end
  end
  return cache
end

local cache = {}

local function update_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local tks = split_into_tokens(line)
    local tkslen = #tks
    if tkslen == 2 then
      local unk = tks[1]
      if unk ~= "" then -- check if ":" is prepended by chars
        if not cache[unk] then
          async_translate(unk, function(out)
            if out == unk then
              dprint("[" .. unk .. "] translation failed (caching it anyway)")
            end
            cache[unk] = out
            -- When the translation has been added to the cache update line
            -- NOTE: This happens only when translating text for the first time
            -- if unk is cached than there wouldn't be any problem in buf output
            vim.schedule(function()
              local cur_lines = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)
              if #cur_lines > 0 then
                cur_lines[1] = string.format("%s: %s", unk, cache[unk])
                vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, cur_lines)
              end
            end)
          end)
          dprint("new [" .. unk .. "]")
        end
        -- NOTE: if cache[unk] is nil we provide an empty string and add a space,
        -- later the fetch callback will update the line, if cache[unk] is not nil
        -- the it contains the cached translation of unk.
        -- Either way we want to update the current line
        local curline = string.format("%s: %s", unk, cache[unk] or "")
        vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, {curline})
      end
    end
  end
end

-- activate glossary mode for current buffer
vim.api.nvim_create_user_command("StartBufGlossMode", function()
  local curbuf = vim.api.nvim_get_current_buf()
  local aug_name = "BufGloss_" .. curbuf
  local aug = vim.api.nvim_create_augroup(aug_name, { clear = true })
  dprint("[" .. curbuf .. "] buf added")

  cache = init_cache()
  dprint("Loaded Cache:\n" .. vim.inspect(cache))
  update_buffer(curbuf)

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = aug,
    buffer = curbuf,
    callback = function(args) update_buffer(args.buf) end,
  })

  vim.api.nvim_buf_set_var(curbuf, "BufGloss_augroup", aug_name)
end, {})

-- deactivate mode for current buffer
vim.api.nvim_create_user_command("StopBufGlossMode", function()
  local curbuf = vim.api.nvim_get_current_buf()
  local ok, aug_name = pcall(vim.api.nvim_buf_get_var, curbuf, "BufGloss_augroup")
  if ok and aug_name then
    vim.api.nvim_del_augroup_by_name(aug_name)
    dprint("[" .. curbuf .. "] buf removed")
  end
end, {})
