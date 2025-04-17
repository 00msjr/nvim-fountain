-- nvim-fountain treesitter integration
local M = {}

-- Check if treesitter is available
function M.is_available()
  local has_ts, _ = pcall(require, "nvim-treesitter.configs")
  return has_ts
end

-- Setup treesitter integration
function M.setup()
  if not M.is_available() then
    return false
  end
  
  local ts_configs = require("nvim-treesitter.configs")
  
  -- Register fountain with treesitter
  -- Note: This is a placeholder. A proper treesitter grammar for fountain
  -- would need to be developed separately.
  ts_configs.setup({
    ensure_installed = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "fountain" },
    },
  })
  
  return true
end

return M
