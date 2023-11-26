function EnterInsertAndSkkeletonWithHira() vim.api.nvim_command('startinsert')
  local keys = vim.api.nvim_replace_termcodes('<Plug>(skkeleton-toggle)', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end
vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji",
  { fg = "#88c0d0", bg = "#2e3440", bold = true })
vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira",
  { fg = "#2e3440", bg = "#a3be8c", bold = true })
vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata",
  { fg = "#2e3440", bg = "#ebcb8b", bold = true })
vim.api.nvim_set_hl(0, "SkkeletonIndicatorHankata",
  { fg = "#2e3440", bg = "#b48ead", bold = true })
vim.api.nvim_set_hl(0, "SkkeletonIndicatorZenkaku",
  { fg = "#2e3440", bg = "#88c0d0", bold = true })
vim.api.nvim_set_hl(0, "SkkeletonIndicatorAbbrev",
  { fg = "#e5e9f0", bg = "#bf616a", bold = true })

require 'skkeleton_indicator'.setup(
  {
    eijiText = "eng",
    hiraText = "hira",
    kataText = "kata",
    fadeOutMs = 6000,
    alwaysShown = true
  }
)
vim.api.nvim_set_keymap('n', 'K', ':lua EnterInsertAndSkkeletonWithHira()<CR>', { noremap = true })
