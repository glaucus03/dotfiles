local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = {
        -- 検索から除外するものを定
        "^.git/",
        "^.cache/",
      },
      vimgrep_arguments = {
        -- ripggrepコマンドのオプション
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "-uu",
      },
    },
    extensions = {
      -- ソート性能を大幅に向上させるfzfを使う
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      file_browser = {
        -- theme = "ivy",
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom insert mode mappings
          },
        },
      },
    },
  })
  require("telescope").load_extension("fzf")

  require("telescope").load_extension("file_browser")
end

return M
