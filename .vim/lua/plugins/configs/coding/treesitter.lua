return {

  -- シンタックス
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not env.is_vscode(),
    config = function()
    
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua',
      'vim',
      'bash',
      'c',
      'cpp',
      'css',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'python',
      'rust',
      'typescript',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })
    end,
    doc = "構文解析"
  },
  {
    'nvim-treesitter/nvim-treesitter-context',

    cond = not env.is_vscode(),
  },
}
