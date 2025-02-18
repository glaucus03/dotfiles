-- plugins/configs/tools/init.lua
return {
  -- ファイル操作
  {
    'nvim-telescope/telescope.nvim',
    cond = not env.is_vscode(),
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function() require('plugins.configs.tools.telescope').setup() end,
    doc = "ファジーファインダー"
  },

  -- Git
  {
    'kdheepak/lazygit.nvim',
    cond = not env.is_vscode(),
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function() require('plugins.configs.tools.lazygit').setup() end,
    doc = "Git UI"
  },
  {
    'sindrets/diffview.nvim',

    cond = not env.is_vscode(),
  },
  {
    'APZelos/blamer.nvim',
    cond = not env.is_vscode(),
  },

  -- ターミナル
  {
    'akinsho/toggleterm.nvim',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.tools.toggleterm').setup() end,
    doc = "ターミナル"
  },

  -- セッション
  {
    'rmagatti/auto-session',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.tools.auto-session').setup() end,
    doc = "セッション管理"
  },
}
