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
          "tsserver",
          "jdtls",
          "java-debug-adapter",
          "java-test",
          "pyright",
        },
        automatic_installation = true
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- キーマッピングなどのセットアップ
              local opts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            end
          })
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
