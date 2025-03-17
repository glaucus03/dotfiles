return {
  -- LSP
  {
    'williamboman/mason.nvim',
    cond = not env.is_vscode(),
    config = function()
      require('mason').setup({
        ui = {
          check_outdated_packages_on_open = true,
          border = 'rounded',
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "cmake",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "html",
          "jsonls",
          "jdtls",         --java
          "checkstyle",    --java
          "ruff",          --python
          "pyright",       --python
          "erb-formatter", --ruby
          "erb-lint",      --ruby
        },
        automatic_installation = true
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- LSPサーバー固有の設定
      --
      local server_settings = {
        pyright = {
          settings = {
            python = {
              extraPaths = { "." },
              venvPaths = '.',
              pythonPath = "./.venv/bin/python",
              analysis = {
                typeCheckingMode = "basic",
                reportOptionalSubscript = "none",
                reportAttributeAccessIssue = "none",
                reportOptionalMemberAccess = false,
                reportReturnType = "none",
                reportGeneralTypeIssues = "none",
                reportMissingImports = "none",    -- importエラーの抑制
                reportUnknownMemberType = "none", -- メンバーの型エラーの抑制
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
              }
            }
          }
        },
        ruby_lsp = {
          enabled = true,
        },
        rubocop = {
          -- If Solargraph and Rubocop are both enabled as an LSP,
          -- diagnostics will be duplicated because Solargraph
          -- already calls Rubocop if it is installed
          enabled = true,
        },
      }

      -- デフォルトのLSP設定を生成する関数
      local function make_default_config()
        return {
          capabilities = capabilities
        }
      end

      -- 除外するLSPサーバーのリスト
      local excluded_servers = {
        ["jdtls"] = true, -- null-lsから起動するため除外
      }

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          if excluded_servers[server_name] then
            return
          end
          local config = vim.tbl_deep_extend(
            "force",
            make_default_config(),
            server_settings[server_name] or {}
          )
          -- jdtls launch from null-ls
          require('lspconfig')[server_name].setup(
            config
          )
        end
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    doc = "LSPマネージャー"
  },
  {
    "tamago324/nlsp-settings.nvim",

    cond = not env.is_vscode(),
    cmd = "LspSettings",
    lazy = true
  },
}
