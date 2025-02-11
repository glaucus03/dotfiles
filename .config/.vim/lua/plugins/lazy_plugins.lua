return {
  -- layout
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('plugins.config.nightfox')
    end,
  },
  { 'catppuccin/nvim',              name = 'catppuccin', priority = 1000 },
  -- windows management
  {
    'simeji/winresizer',
    init = function()
      require('plugins.config.winresizer')
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugins.config.lualine')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- config = function()
    -- end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
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
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugins.config.toggleterm')
    end,
  },
  {
    'APZelos/blamer.nvim',
  },
  -- edit action
  {
    'numToStr/Comment.nvim',
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
    config = function()
      require("plugins.config.nvim-dap").setup_ui()
    end,
    lazy = true,
  },
  -- cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require('plugins.config.nvim-cmp')
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-buffer',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-path',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-vsnip',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-cmdline',
    event = 'ModeChanged',
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-calc',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/cmp-emoji',
    event = 'InsertEnter',
  },
  {
    'onsails/lspkind.nvim',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/vim-vsnip',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/vim-vsnip-integ',
    event = 'InsertEnter',
  },
  {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
  },
  -- images
  {
    "michaelrommel/nvim-silicon",
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
}
