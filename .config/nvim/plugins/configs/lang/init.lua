return {
  -- Flutter/Dart
  {
    'akinsho/flutter-tools.nvim',
    cond = not env.is_vscode(),
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function() require('plugins.configs.lang.flutter') end,
    doc = "Flutter開発支援"
  },
}
