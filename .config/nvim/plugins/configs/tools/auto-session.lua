local M = {}

function M.setup()
  require("auto-session").setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/dev/*" },
  }
end

return M
