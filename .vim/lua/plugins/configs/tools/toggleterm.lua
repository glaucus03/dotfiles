return {
  -- ターミナル
  {
    'akinsho/toggleterm.nvim',
    cond = not env.is_vscode(),
    config = function()
    
  require("toggleterm").setup()
    end,
    doc = "ターミナル"
  },
}
