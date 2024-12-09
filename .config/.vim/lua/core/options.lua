function SetOptions()
  local api = vim.api

  local opts = {
    splitright = true,
    splitbelow = true,
    clipboard = 'unnamedplus',
    hlsearch = true,
    mouse = 'a',
    whichwrap = 'b,s,h,l,<,>,[,]',
    ignorecase = true,
    wrapscan = true,
    smartcase = true,
    pumheight = 10,
    lazyredraw = true,
    showcmd = false,
    guicursor = vim.o.guicursor..',a:blinkon0',
    encoding = 'utf-8',
    fileencoding = 'utf-8',
    undodir = vim.env.HOME..'/.local/share/nvim/backup',
    breakindent = true,
    termguicolors = true,
    showmatch = true,
    matchtime = 1
  }

  local wopts = {
    cursorline = true,
    signcolumn = 'yes',
    number = true,
    relativenumber = true,
    foldmethod = 'marker'
  }

  local bopts = {
    autoindent = true,
    smartindent = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    undofile = true,
    swapfile = false
  }

  for opt, val in pairs(opts) do
    vim.api.nvim_set_option(opt, val)
  end

  for opt, val in pairs(wopts) do
    vim.api.nvim_win_set_option(0, opt, val)
  end

  for opt, val in pairs(bopts) do
    vim.api.nvim_buf_set_option(0, opt, val)
  end
end

SetOptions()
vim.cmd('set clipboard+=unnamedplus')

vim.cmd('autocmd FileType * lua SetOptions()')
vim.opt.runtimepath:append('~/.vim')

vim.o.termguicolors = true
