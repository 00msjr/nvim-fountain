-- nvim-fountain keymaps module
local M = {}

-- Setup keymaps for fountain files
function M.setup(config)
  -- Get keymap config with defaults
  local keymaps = config.keymaps or {}
  
  -- Define buffer-local keymaps
  local function set_keymap(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = 0  -- Current buffer
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  
  -- Navigate between scene headings
  set_keymap('n', keymaps.next_scene or ']]', function()
    require('nvim-fountain').next_section(false)
  end, { desc = "Next scene heading" })
  
  set_keymap('n', keymaps.prev_scene or '[[', function()
    require('nvim-fountain').next_section(true)
  end, { desc = "Previous scene heading" })
  
  -- Make line uppercase then <cr>
  set_keymap('n', keymaps.uppercase_line or '<S-CR>', 'gUU<CR>', 
    { desc = "Make line uppercase and move to next line" })
end

return M
