-- read global variable
vim.fn['skkeleton#config']({ globalJisyo = vim.fn.getenv('SKK_JISYO_PATH') })
vim.api.nvim_set_keymap('i', '<c-k>', "<Plug>(skkeleton-toggle)", { noremap = false })
