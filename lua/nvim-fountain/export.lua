-- nvim-fountain export module
local M = {}

-- Export to PDF using afterwriting
function M.export_pdf(output_path)
  local current_file = vim.fn.expand('%:p')
  output_path = output_path or vim.fn.expand('%:p:r') .. '.pdf'
  
  -- Check if afterwriting is installed
  if vim.fn.executable('afterwriting') ~= 1 then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('afterwriting --source "%s" --pdf "%s"', current_file, output_path)
  vim.notify("Exporting to PDF...", vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to PDF failed", vim.log.levels.ERROR)
      end
    end
  })
end

-- Export to HTML
function M.export_html(output_path)
  local current_file = vim.fn.expand('%:p')
  output_path = output_path or vim.fn.expand('%:p:r') .. '.html'
  
  -- Check if afterwriting is installed
  if vim.fn.executable('afterwriting') ~= 1 then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('afterwriting --source "%s" --html "%s"', current_file, output_path)
  vim.notify("Exporting to HTML...", vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to HTML failed", vim.log.levels.ERROR)
      end
    end
  })
end

-- Export to FDX (Final Draft)
function M.export_fdx(output_path)
  local current_file = vim.fn.expand('%:p')
  output_path = output_path or vim.fn.expand('%:p:r') .. '.fdx'
  
  -- Check if afterwriting is installed
  if vim.fn.executable('afterwriting') ~= 1 then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Run afterwriting
  local cmd = string.format('afterwriting --source "%s" --fdx "%s"', current_file, output_path)
  vim.notify("Exporting to Final Draft...", vim.log.levels.INFO)
  
  -- Use job to run in background
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("Exported to " .. output_path, vim.log.levels.INFO)
      else
        vim.notify("Export to Final Draft failed", vim.log.levels.ERROR)
      end
    end
  })
end

-- Preview in browser
function M.preview()
  local current_file = vim.fn.expand('%:p')
  local temp_html = vim.fn.tempname() .. '.html'
  
  -- Check if afterwriting is installed
  if vim.fn.executable('afterwriting') ~= 1 then
    vim.notify("afterwriting not found. Install with: npm install -g afterwriting", vim.log.levels.ERROR)
    return
  end
  
  -- Save current buffer
  vim.cmd('write')
  
  -- Convert to HTML
  local cmd = string.format('afterwriting --source "%s" --html "%s"', current_file, temp_html)
  vim.notify("Generating preview...", vim.log.levels.INFO)
  
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
        vim.notify("Preview generation failed", vim.log.levels.ERROR)
      end
    end
  })
end

return M
