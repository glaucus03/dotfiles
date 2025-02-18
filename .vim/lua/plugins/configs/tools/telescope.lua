return {
  -- ファイル操作
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not is_vscode,
    build = 'make',
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not env.is_vscode(),
    dependencies = {
      'nvim-lua/plenary.nvim',

      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
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
      require("telescope").load_extension("file_browser")
    end,
    doc = "ファジーファインダー"
  },
}

