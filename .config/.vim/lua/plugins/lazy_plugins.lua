local is_vscode = vim.g.vscode

return {
  -- layout
  {
    'EdenEast/nightfox.nvim',
    cond = not is_vscode,
    config = function()
      require('plugins.config.nightfox')
    end,
  },
  { 'catppuccin/nvim',              name = 'catppuccin', priority = 1000 },
  -- windows management
  {
    'simeji/winresizer',
    cond = not is_vscode,
    init = function()
      require('plugins.config.winresizer')
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cond = not is_vscode,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cmd = {
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeFocus',
      'NvimTreeToggle',
    },
    config = function()
      require('plugins.config.nvim-tree')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    cond = not is_vscode,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugins.config.lualine')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not is_vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- config = function()
    -- end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not is_vscode,
    build = 'make',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    cond = not is_vscode,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugins.config.telescope')
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    cond = not is_vscode,
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'ibhagwan/fzf-lua' },
    },
    config = function()
      require('plugins.config.nvim-neoclip')
    end,
  },
  -- code layout
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.config.nvim-treesitter')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins.config.nvim-colorizer')
    end,
  },
  -- session
  {
    'rmagatti/auto-session',
    cond = not is_vscode,
    config = function()
      require('plugins.config.auto-session')
    end,
  },
  -- git
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugins.config.lazygit')
    end,
  },
  {
    'sindrets/diffview.nvim',
    cond = not is_vscode,
  },
  {
    'akinsho/toggleterm.nvim',
    cond = not is_vscode,
    config = function()
      require('plugins.config.toggleterm')
    end,
  },
  {
    'APZelos/blamer.nvim',
    cond = not is_vscode,
  },
  -- edit action
  {
    'numToStr/Comment.nvim',
    cond = not is_vscode,
    config = function()
      require('plugins.config.comment')
    end,
  },
  {
    'monaqa/dial.nvim',
    config = function()
      require('plugins.config.dial')
    end,
  },
  -- edit viewing
  {
    'petertriho/nvim-scrollbar',
    cond = not is_vscode,
    config = function()
      require('plugins.config.nvim-scrollbar')
    end,
  },
  {
    'andymass/vim-matchup',
    event = 'CursorMoved',
    config = function()
      require('plugins.config.vim-matchup')
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('plugins.config.which-key')
    end,
    dependencies = {
      'echasnovski/mini.icons',
    },
  },
  -- move
  {
    'hadronized/hop.nvim',
    config = function()
      require('plugins.config.hop')
    end,
  },
  {
    'rhysd/clever-f.vim',
  },
  -- lsp
  {
    'williamboman/mason.nvim',
    cond = not is_vscode,
    config = function()
      require('plugins.config.mason')
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  { "tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  {
    "jay-babu/mason-null-ls.nvim",
    cond = not is_vscode,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      'nvimtools/none-ls.nvim',
    },
    config = function()
      local null_ls = require("null-ls")
      local home = vim.fn.expand("$HOME")
      null_ls.setup({
        fallback_severity = vim.diagnostic.severity.HINT,
        sources = {
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.diagnostics.checkstyle.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
            extra_args = { "-c", home .. "/dev/lib/google_checks.xml" },
          }),
        },
        -- debug = true
      })
      require("mason-null-ls").setup({
        handlers = {},
      })
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   dependencies = {
  --   "jay-babu/mason-null-ls.nvim",
  --     "gbprod/none-ls-shellcheck.nvim", -- shellcheck
  --     "nvimtools/none-ls-extras.nvim",  -- eslint_d
  --   },
  --   config = function()
  --     -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
  --     local null_ls = require("null-ls")
  --     local home = vim.fn.expand("$HOME")
  --     null_ls.setup({
  --       fallback_severity = vim.diagnostic.severity.HINT,
  --       sources = {
  --         null_ls.builtins.formatting.google_java_format,
  --         null_ls.builtins.diagnostics.checkstyle.with({
  --           diagnostics_postprocess = function(diagnostic)
  --             diagnostic.severity = vim.diagnostic.severity.HINT
  --           end,
  --           extra_args = { "-c", home .. "/dev/lib/google_checks.xml" },
  --         }),
  --       },
  --       -- debug = true
  --     })
  --     require('mason-null-ls').setup({
  --       automatic_setup = true,
  --       handlers = {},
  --     })
  --   end
  -- },

  -- dap
  {
    "mfussenegger/nvim-dap",
    cond = not is_vscode,
    config = function()
      require("plugins.config.nvim-dap").setup()
    end,
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    cond = not is_vscode,
    config = function()
      require("plugins.config.nvim-dap").setup_ui()
    end,
    lazy = true,
  },
  -- cmp
  {
    'hrsh7th/nvim-cmp',
    cond = not is_vscode,
    event = 'InsertEnter',
    config = function()
      require('plugins.config.nvim-cmp')
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-buffer',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-path',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-vsnip',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-cmdline',
    cond = not is_vscode,
    event = 'ModeChanged',
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-calc',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-emoji',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'onsails/lspkind.nvim',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/vim-vsnip',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'hrsh7th/vim-vsnip-integ',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  {
    'rafamadriz/friendly-snippets',
    cond = not is_vscode,
    event = 'InsertEnter',
  },
  -- images
  {
    "michaelrommel/nvim-silicon",
    cond = not is_vscode,
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    opts = {
      -- Configuration here, or leave empty to use defaults
      line_offset = function(args)
        return args.line1
      end,
      to_clipboard = true,
      font = 'Cica',
      background = '#fff0',
      pad_horiz = 50,
      pad_vert = 40,
    }
  },
  -- dev
  {
    'akinsho/flutter-tools.nvim',
    cond = not is_vscode,
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('plugins.config.flutter-tools')
    end,
  },
  {
    'yetone/avante.nvim',
    cond = not is_vscode,
    event = 'VeryLazy',
    lazy = false,
    version = false, -- Set this to '*' to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'hrsh7th/nvim-cmp',            -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua',      -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
