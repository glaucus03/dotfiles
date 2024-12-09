
local M = {}

M.setup = function()
end

local function get_word_under_cursor()
  return vim.fn.expand("<cword>")
end

local function get_next_img_number()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local highest_num = 0
  for _, line in ipairs(lines) do
    for num in string.gmatch(line, "%!%[img(%d+)%]") do
      num = tonumber(num)
      if num and num > highest_num then
        highest_num = num
      end
    end
  end
  return highest_num + 1
end

M.take_and_insert = function()
  local screenshot_dir = vim.fn.expand("%:p:h") .. "/.img"
  local date_str = os.date("%Y%m%d_%H%M%S")
  local filename = "screenshot_" .. date_str .. ".png"
  local filepath = screenshot_dir .. "/" .. filename
  local cursorword = get_word_under_cursor()
  local img_num = get_next_img_number()
  local description_name = cursorword ~= "" and cursorword or ("img" .. img_num)

  if vim.fn.isdirectory(screenshot_dir) == 0 then
    local mkdir_result = vim.fn.mkdir(screenshot_dir, "p")
    if mkdir_result == 0 then
      print("Error: Could not create the screenshot directory: " .. screenshot_dir)
      return
    else
      print("Screenshot directory created: " .. screenshot_dir)
    end
  end

  local screenshot_cmd = ""
  -- Determine the appropriate screenshot command for the OS
  if vim.fn.has("mac") == 1 then
    screenshot_cmd = "screencapture -i " .. vim.fn.shellescape(filepath)
  elseif vim.fn.has("unix") == 1 then
    screenshot_cmd = "scrot -s " .. vim.fn.shellescape(filepath)
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    print("Error: Taking screenshots is not supported on Windows through this plugin.")
    return
  end

  if screenshot_cmd ~= "" then
    local shell_result = vim.fn.system(screenshot_cmd)
    if vim.v.shell_error ~= 0 then
      print("Error: Failed to take a screenshot.")
      return
    end
  end

  local relative_filepath = string.format(".img/%s", filename)
  local link_text = string.format("![%s](%s)", description_name, relative_filepath)
  vim.api.nvim_put({link_text}, "l", true, true)
end

return M
