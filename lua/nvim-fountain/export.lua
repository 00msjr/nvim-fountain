-- nvim-fountain export module
local M = {}

-- Default export configuration
local default_config = {
  output_dir = nil,
  pdf = {
    options = "--overwrite --font Courier",
  },
  html = {
    options = "--overwrite",
  },
  fdx = {
    options = "--overwrite",
  },
}

-- Get export configuration
local function get_config()
  local config = require('nvim-fountain').config.export or {}
  return vim.tbl_deep_extend("force", default_config, config)
end

-- Find afterwriting executable
local function find_afterwriting()
  -- Check if directly in PATH
  if vim.fn.executable('afterwriting') == 1 then
    return 'afterwriting'
  end
  
  -- Try to find afterwriting in common npm paths
  local possible_paths = {
    vim.fn.expand('~/.npm-global/bin/afterwriting'),
    vim.fn.expand('~/.nvm/versions/node/*/bin/afterwriting'),
    vim.fn.expand('/usr/local/bin/afterwriting'),
    vim.fn.expand('/opt/homebrew/bin/afterwriting'),
    vim.fn.expand('~/AppData/Roaming/npm/afterwriting.cmd'), -- Windows
  }
  
  for _, path in ipairs(possible_paths) do
    local expanded_paths = vim.fn.glob(path, false, true)
    for _, expanded_path in ipairs(expanded_paths) do
      if vim.fn.executable(expanded_path) == 1 then
        return expanded_path
      end
    end
  end
  
  -- Try alternative command names
  local alternative_names = {'afterwriting-cli', 'afterwritingcli', 'aw'}
  for _, name in ipairs(alternative_names) do
    if vim.fn.executable(name) == 1 then
      return name
    end
  end
  
  return nil
end

-- Export to PDF using afterwriting
function M.export_pdf(output_path)
  local config = get_config()
  local current_file = vim.fn.expand('%:p')
  
  -- Determine output path
  if not output_path then
    if config.output_dir then
      local filename = vim.fn.fnamemodify(current_file, ':t:r') .. '.pdf'
      output_path = config.output_dir .. '/' .. filename
    else
      output_path = vim.fn.expand('%:p:r') .. '.pdf'
    end
  end
  
  -- Find afterwriting
  local afterwriting_path = find_afterwriting()
  if not afterwriting_path then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Using afterwriting at: " .. afterwriting_path, vim.log.levels.INFO)
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('"%s" --source "%s" --pdf "%s" %s', 
                           afterwriting_path, current_file, output_path, config.pdf.options or "")
  
  vim.notify("Exporting to PDF with command: " .. cmd, vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to PDF failed with exit code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local error_msg = table.concat(data, "\n")
        vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
      end
    end
  })
end

-- Export to HTML
function M.export_html(output_path)
  local config = get_config()
  local current_file = vim.fn.expand('%:p')
  
  -- Determine output path
  if not output_path then
    if config.output_dir then
      local filename = vim.fn.fnamemodify(current_file, ':t:r') .. '.html'
      output_path = config.output_dir .. '/' .. filename
    else
      output_path = vim.fn.expand('%:p:r') .. '.html'
    end
  end
  
  -- Find afterwriting
  local afterwriting_path = find_afterwriting()
  if not afterwriting_path then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Using afterwriting at: " .. afterwriting_path, vim.log.levels.INFO)
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('"%s" --source "%s" --html "%s" %s', 
                           afterwriting_path, current_file, output_path, config.html.options or "")
  
  vim.notify("Exporting to HTML with command: " .. cmd, vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to HTML failed with exit code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local error_msg = table.concat(data, "\n")
        vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
      end
    end
  })
end

-- Export to FDX (Final Draft)
function M.export_fdx(output_path)
  local config = get_config()
  local current_file = vim.fn.expand('%:p')
  
  -- Determine output path
  if not output_path then
    if config.output_dir then
      local filename = vim.fn.fnamemodify(current_file, ':t:r') .. '.fdx'
      output_path = config.output_dir .. '/' .. filename
    else
      output_path = vim.fn.expand('%:p:r') .. '.fdx'
    end
  end
  
  -- Find afterwriting
  local afterwriting_path = find_afterwriting()
  if not afterwriting_path then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Using afterwriting at: " .. afterwriting_path, vim.log.levels.INFO)
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('"%s" --source "%s" --fdx "%s" %s', 
                           afterwriting_path, current_file, output_path, config.fdx.options or "")
  
  vim.notify("Exporting to Final Draft with command: " .. cmd, vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to Final Draft failed with exit code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local error_msg = table.concat(data, "\n")
        vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
      end
    end
  })
end

-- Preview in browser
function M.preview()
  local current_file = vim.fn.expand('%:p')
  local temp_html = vim.fn.tempname() .. '.html'
  
  -- Find afterwriting
  local afterwriting_path = find_afterwriting()
  if not afterwriting_path then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Using afterwriting at: " .. afterwriting_path, vim.log.levels.INFO)
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('"%s" --source "%s" --html "%s" --overwrite', 
                           afterwriting_path, current_file, temp_html)
  
  vim.notify("Generating preview with command: " .. cmd, vim.log.levels.INFO)
  
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        -- Open in browser
        local open_cmd
        if vim.fn.has('mac') == 1 then
          open_cmd = 'open'
        elseif vim.fn.has('unix') == 1 then
          open_cmd = 'xdg-open'
        elseif vim.fn.has('win32') == 1 then
          open_cmd = 'start'
        end
        
        if open_cmd then
          vim.fn.system(string.format('%s "%s"', open_cmd, temp_html))
          vim.notify("Preview opened in browser", vim.log.levels.INFO)
        else
          vim.notify("Could not determine how to open the browser", vim.log.levels.ERROR)
        end
      else
        vim.notify("Preview generation failed with exit code: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local error_msg = table.concat(data, "\n")
        vim.notify("Error: " .. error_msg, vim.log.levels.ERROR)
      end
    end
  })
end

return M
