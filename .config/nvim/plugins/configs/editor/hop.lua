local M = {}

function M.setup()
  local hop = require("hop")
  hop.setup {
    multi_windows = true,
  }
end

return M
