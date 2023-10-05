local api = vim.api

vim.cmd('augroup MyAutoCmd')
vim.cmd('autocmd!')
vim.cmd('augroup END')

vim.cmd('filetype off')
vim.cmd('syntax off')
-- vim.api.nvim_exec('language en_US', true)


vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local vars = {
  python_host_prog = '/usr/bin/python2',
  python3_host_prog = '/usr/bin/python3',
  loaded_matchparen = 1,
  vimsyn_embed = 1,
  loaded_python_provider = 0,
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
  loaded_rrhelper = 1,
  loaded_vimball = 1,
  loaded_vimballPlugin = 1,
  loaded_getscript = 1,
  loaded_getscriptPlugin = 1,
  loaded_logipat = 1,
  loaded_man = 1,
}

for var, val in pairs(vars) do
  api.nvim_set_var(var, val)
end

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.cmd('command! ToggleNum set rnu!')

vim.cmd([[
if executable('fctix')
  autocmd InsertLeave * :call system('fctix-remote -c')
  autocmd CmdluneLeave * :call system('fctix-remote -c')
]]
)

vim.env.MYVIMDEIN = '~/.vim/dein.toml'

api.nvim_create_user_command('Memo', function(opts)
  vim.cmd("e ".."~/dev/memo/"..os.date("%Y%m%d").."memo.md")
end,
{}
)
api.nvim_create_user_command('Todo', function(opts)
  vim.cmd("e ".."~/dev/Todo.md")
end,
{}
)
api.nvim_create_user_command('Cd', function(opts)
  vim.cmd("cd%:p:h")
end,
{}
)
api.nvim_create_user_command('CdVimSetting', function(opts)
  vim.cmd("cd ~/.vim")
end,
{}
)
api.nvim_create_user_command('CdDevTmp', function(opts)
  vim.cmd("cd ~/dev/tmp/")
end,
{}
)
