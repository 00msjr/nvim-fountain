-- Fountain filetype plugin
local keymaps = require('nvim-fountain.keymaps')

-- Set up buffer-local options
vim.bo.commentstring = "/* %s */"

-- Set up keymaps
keymaps.setup(require('nvim-fountain').config)

-- Set up any buffer-local commands
vim.api.nvim_buf_create_user_command(0, "FountainFormat", function()
  -- Add formatting functionality here
  vim.notify("Formatting fountain document", vim.log.levels.INFO)
end, { desc = "Format fountain document" })
