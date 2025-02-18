local M = {}

function M.setup()
  require('telescope').load_extension('lazygit')
end

return M
