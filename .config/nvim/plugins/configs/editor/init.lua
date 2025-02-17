return {
  -- 基本編集機能
  {
    'numToStr/Comment.nvim',
    cond = not env.is_vscode(),
    config = function() require('plugins.configs.editor.comment') end,
    doc = "コメントアウト"
  },
  {
    'monaqa/dial.nvim',
    config = function() require('plugins.configs.editor.dial') end,
    doc = "数値やテキストのインクリメント"
  },
  {
    'andymass/vim-matchup',
    event = 'CursorMoved',
    config = function() require('plugins.configs.editor.matchup') end,
    doc = "対応する括弧等のジャンプ"
  },

  -- ナビゲーション
  {
    'hadronized/hop.nvim',
    config = function() require('plugins.configs.editor.hop') end,
    doc = "クイックジャンプ"
  },
  {
    'rhysd/clever-f.vim',
    doc = "f/t検索の拡張"
  },
}
