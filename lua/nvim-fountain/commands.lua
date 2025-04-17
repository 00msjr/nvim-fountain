-- nvim-fountain commands module
local M = {}

-- Calculate screenplay statistics
function M.get_stats()
  local stats = {
    scenes = 0,
    characters = {},
    dialogue_lines = 0,
    action_lines = 0,
    total_lines = vim.fn.line('$'),
  }
  
  -- Count scenes, characters, and dialogue
  for i = 1, stats.total_lines do
    local line = vim.fn.getline(i)
    
    -- Scene headings
    if line:match("^%s*[%.]*%s*[IE][XNT][XT]%.?%s") then
      stats.scenes = stats.scenes + 1
    end
    
    -- Characters (all caps lines followed by dialogue)
    if line:match("^%s*[A-Z][%s%u%d%.%-%&]+$") then
      local character = line:match("^%s*([A-Z][%s%u%d%.%-%&]+)$"):gsub("^%s+", ""):gsub("%s+$", "")
      stats.characters[character] = (stats.characters[character] or 0) + 1
      
      -- Count dialogue lines
      local j = i + 1
      while j <= stats.total_lines do
        local next_line = vim.fn.getline(j)
        if next_line:match("^%s*$") then
          break
        elseif not next_line:match("^%s*%(") then -- Skip parentheticals
          stats.dialogue_lines = stats.dialogue_lines + 1
        end
        j = j + 1
      end
    end
    
    -- Action lines (not dialogue, not scene headings, not empty)
    if not line:match("^%s*$") and 
       not line:match("^%s*[%.]*%s*[IE][XNT][XT]%.?%s") and
       not line:match("^%s*[A-Z][%s%u%d%.%-%&]+$") and
       not line:match("^%s*%(") then
      stats.action_lines = stats.action_lines + 1
    end
  end
  
  -- Count unique characters
  stats.unique_characters = 0
  for _ in pairs(stats.characters) do
    stats.unique_characters = stats.unique_characters + 1
  end
  
  return stats
end

-- Display screenplay statistics
function M.show_stats()
  local stats = M.get_stats()
  
  -- Create a temporary buffer for stats
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  
  -- Add stats to buffer
  local lines = {
    "# Fountain Screenplay Statistics",
    "",
    "- Total scenes: " .. stats.scenes,
    "- Unique characters: " .. stats.unique_characters,
    "- Dialogue lines: " .. stats.dialogue_lines,
    "- Action lines: " .. stats.action_lines,
    "- Total lines: " .. stats.total_lines,
    "",
    "## Character Appearances",
    ""
  }
  
  -- Sort characters by number of appearances
  local sorted_chars = {}
  for char, count in pairs(stats.characters) do
    table.insert(sorted_chars, {name = char, count = count})
  end
  table.sort(sorted_chars, function(a, b) return a.count > b.count end)
  
  -- Add character stats
  for _, char in ipairs(sorted_chars) do
    table.insert(lines, "- " .. char.name .. ": " .. char.count)
  end
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Open in a split window
  vim.cmd('vsplit')
  vim.api.nvim_win_set_buf(0, buf)
  vim.bo[buf].filetype = 'markdown'
  vim.bo[buf].modifiable = false
end

-- Format the fountain document
function M.format_document()
  -- Implement formatting logic here
  vim.notify("Formatting fountain document", vim.log.levels.INFO)
end

return M
