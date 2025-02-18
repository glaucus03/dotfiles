return {
  -- Git
  {
    'kdheepak/lazygit.nvim',
    cond = not env.is_vscode(),
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
    
  require('telescope').load_extension('lazygit')
    end,
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
}
