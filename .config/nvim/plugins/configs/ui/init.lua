return {
  -- テーマ
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.ui.colorscheme').setup() end,
    doc = "メインのカラースキーム"
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- ステータスライン/UI
  {
    'nvim-lualine/lualine.nvim',
    cond = not env.is_vscode(),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('plugins.configs.ui.statusline').setup() end,
    doc = "ステータスライン"
  },
  {
    'nvim-tree/nvim-tree.lua',
    cond = not env.is_vscode(),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeFocus', 'NvimTreeToggle' },
    config = function() require('plugins.configs.ui.tree').setup() end,
    doc = "ファイルエクスプローラー"
  },
  {
    'petertriho/nvim-scrollbar',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.ui.scrollbar').setup() end,
    doc = "スクロールバー"
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('plugins.configs.ui.colorizer').setup() end,
    doc = "カラーコードのハイライト"
  },
}
