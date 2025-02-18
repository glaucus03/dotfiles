return {
  -- Flutter/Dart
  {
    'akinsho/flutter-tools.nvim',
    cond = not env.is_vscode(),
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function() require('plugins.configs.lang.flutter').setup() end,
    doc = "Flutter開発支援"
  },
}
