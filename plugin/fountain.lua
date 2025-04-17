-- Fountain plugin entry point
if vim.g.loaded_nvim_fountain == 1 then
  return
end
vim.g.loaded_nvim_fountain = 1

-- Set up file detection
vim.filetype.add({
  extension = {
    fountain = "fountain",
  },
})

-- Create user commands
vim.api.nvim_create_user_command("FountainStats", function()
  -- Add functionality to show screenplay statistics
  vim.notify("Screenplay statistics coming soon", vim.log.levels.INFO)
end, { desc = "Show fountain screenplay statistics" })
