local M = {}

function M.setup()
  local api = require('nvim-tree.api')

  -- キーマッピングの設定
  local function on_attach(bufnr)
    local function map(key, action, desc)
      vim.keymap.set('n', key, action, {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
      })
    end

    -- 基本操作
    map('<CR>', api.node.open.edit, 'Open')
    map('<C-v>', api.node.open.vertical, 'Open: Vertical Split')
    map('<C-s>', api.node.open.horizontal, 'Open: Horizontal Split')
    map('<BS>', api.node.navigate.parent_close, 'Up')
    map('<Tab>', api.node.open.preview, 'Open Preview')

    -- ナビゲーション
    map('>', api.node.navigate.sibling.next, 'Next Sibling')
    map('<', api.node.navigate.sibling.prev, 'Previous Sibling')
    map('P', api.node.navigate.parent, 'Parent Directory')
    map('J', api.node.navigate.sibling.last, 'Last Sibling')
    map('K', api.node.navigate.sibling.first, 'First Sibling')

    -- ファイル操作
    map('a', api.fs.create, 'Create')
    map('d', api.fs.remove, 'Delete')
    map('D', api.fs.trash, 'Trash')
    map('r', api.fs.rename, 'Rename')
    map('x', api.fs.cut, 'Cut')
    map('c', api.fs.copy.node, 'Copy')
    map('p', api.fs.paste, 'Paste')

    -- その他
    map('R', api.tree.reload, 'Refresh')
    map('?', api.tree.toggle_help, 'Help')
    map('q', api.tree.close, 'Close')
  end

  -- diagnosticsのリフレッシュを行う関数
  local function setup_diagnostics_refresh()
    local diagnostic_handler = vim.diagnostic.handlers.virtual_text
    local ns = vim.diagnostic.get_namespace(vim.diagnostic.get_namespaces().nvim_lsp)

    -- 診断情報が更新されたときのハンドラ
    vim.diagnostic.handlers.virtual_text = {
      show = function(_, bufnr, diagnostics, opts)
        diagnostic_handler.show(ns, bufnr, diagnostics, opts)
        -- nvim-treeの診断表示を更新
        api.tree.reload()
      end,
      hide = function(_, bufnr)
        diagnostic_handler.hide(ns, bufnr)
        api.tree.reload()
      end,
    }

    -- LSPの診断情報が変更されたときのイベントハンドラ
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function()
        -- 少し遅延を入れて更新（連続更新の防止）
        vim.defer_fn(function()
          api.tree.reload()
        end, 100)
      end,
    })
  end

  -- nvim-treeの設定
  require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    filesystem_watchers = {
      enable = true,            -- ファイルシステムの監視を有効化
      debounce_delay = 50,      -- 更新の遅延時間
      ignore_dirs = { ".git" }, -- 監視から除外するディレクトリ
    },

    -- 自動更新の設定
    auto_reload_on_write = true,
    reload_on_bufenter = true, -- バッファ切り替え時に更新
    update_focused_file = {
      enable = true,           -- フォーカスされたファイルの状態を更新
      update_root = false,     -- ルートディレクトリは更新しない
      ignore_list = {},        -- 更新を無視するパターン
    },
    view = {
      width = 40,
      side = 'left',
      preserve_window_proportions = true,
    },
    renderer = {
      add_trailing = false,
      highlight_git = true,
      highlight_opened_files = "none",
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "signcolumn",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "M",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true, -- 開いているディレクトリでも表示
      debounce_delay = 50,      -- 更新の遅延時間
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "󱄋",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    on_attach = on_attach,
  })
end

return M
