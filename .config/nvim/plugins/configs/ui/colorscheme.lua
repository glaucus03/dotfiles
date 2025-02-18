local M = {}

function M.setup()
  require('nightfox').setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
      inverse = {
        match_paren = true,
        visual = true,
        search = true,
      },
    },
    groups = {
      all = {
        -- カスタムハイライトグループの設定
        CursorLine = { bg = "bg2" },
      }
    }
  })
  vim.cmd("colorscheme nightfox")
end

return M
