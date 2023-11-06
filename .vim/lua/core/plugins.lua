-- setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = require('plugins.lazy_plugins')

require('lazy').setup(plugins)

-- setup screenshot
local api = vim.api

require('screenshot').setup()
api.nvim_set_keymap('i', '<c-s>', "<esc>:lua require('screenshot').take_and_insert()<CR>", { noremap = true })
