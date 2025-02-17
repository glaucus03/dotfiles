return {
  -- LSP
  {
    'williamboman/mason.nvim',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.coding.mason') end,
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

  -- 補完
  {
    'hrsh7th/nvim-cmp',
    cond = not env.is_vscode(),
    event = 'InsertEnter',
    config = function() require('plugins.configs.coding.cmp') end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
    },
    doc = "補完エンジン"
  },

  -- シンタックス
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.coding.treesitter') end,
    doc = "構文解析"
  },
  {
    'nvim-treesitter/nvim-treesitter-context',

    cond = not env.is_vscode(),
  },
}
