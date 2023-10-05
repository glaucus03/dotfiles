local api = vim.api

api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })
api.nvim_set_keymap('i', 'っj', '<esc>', { noremap = true })
api.nvim_set_keymap('n', '<c-h>', '<c-w><c-h>', { noremap = true })
api.nvim_set_keymap('n', '<c-j>', '<c-w><c-j>', { noremap = true })
api.nvim_set_keymap('n', '<c-k>', '<c-w><c-k>', { noremap = true })
api.nvim_set_keymap('n', '<c-l>', '<c-w><c-l>', { noremap = true })
api.nvim_set_keymap('n', '<c-c>', ':noh<cr><esc>', { noremap = true })
api.nvim_set_keymap('n', ';', ':', { noremap = true})

api.nvim_set_keymap('t', '<c-q>', '<c-\\><c-n><c-w>q', {noremap=true})
api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', {noremap=true})

api.nvim_set_keymap('n','<c-p>',':let @*=expand(\'%:p\')<cr> :let @+=expand(\'%:p\')<cr>:echo expand(\'%:p\')<cr>',{noremap=true})
api.nvim_set_keymap('n', '%', ':source %<cr>:echo \'source % done.\'<cr>', {noremap = true})

api.nvim_set_keymap('n', '%', ':source %<cr>:echo \'source % done.\'<cr>', {noremap = true})
api.nvim_set_keymap('n', '%', ':source %<cr>:echo \'source % done.\'<cr>', {noremap = true})

