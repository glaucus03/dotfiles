return {
  -- layout
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('plugins.config.nightfox')
    end,
  },
  -- {
  --   'christianchiarulli/nvcode-color-schemes.vim',
  --   config = function()
  --     --require('plugins.config.nvcode-color-schemes')
  --     vim.cmd('colorscheme ' .. 'xoria')
  --   end,
  -- },
  -- {
  --   'antonk52/lake.nvim',
  --   config = function()
  --     vim.cmd('colorscheme ' .. 'deep-space')
  --   end,
  -- },
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
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeFocus",
      "NvimTreeToggle",
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
    config = function()
      require('plugins.config.telescope')
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim" 
    },
    config = function()
      require('plugins.config.telescope-file-browser')
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
    config = function()
      require('plugins.config.diffview')
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugins.config.toggleterm')
    end,
  },
  {
    'APZelos/blamer.nvim',
    config = function()
      require('plugins.config.blamer')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.config.gitsigns')
    end,
  },
  -- edit action
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugins.config.comment')
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
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.config.chatgpt")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- edit viewing
  {
    'andymass/vim-matchup',
    event = 'CursorMoved',
    config = function()
      require('plugins.config.vim-matchup')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.config.indent-blankline')
    end,
  },
  -- lsp
  {
    'neoclide/coc.nvim',
    config = function()
      require('plugins.config.coc-nvim')
    end,
    branch = "release",
  },
  -- cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter, CmdlineEnter',
    config = function()
      require('plugins.config.nvim-cmp')
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-buffer',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-path',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-vsnip',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-cmdline',
    event = 'ModeChanged'
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/cmp-calc',
    event = 'InsertEnter'
  },
  {
    'onsails/lspkind.nvim',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/vim-vsnip',
    event = 'InsertEnter'
  },
  {
    'hrsh7th/vim-vsnip-integ',
    event = 'InsertEnter'
  },
  {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter'
  },
  -- debugger
  -- {
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     require('plugins.config.nvim-dap')
  --   end,
  -- },
  -- {
  --   'rcarriga/nvim-dap-ui',
  --   config = function()
  --     require('plugins.config.nvim-dap-ui')
  --   end,
  -- },
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   config = function()
  --     require('plugins.config.nvim-dap-virtual-text')
  --   end,
  -- },

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
}
