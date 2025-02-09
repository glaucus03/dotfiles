vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require("which-key")

wk.add({
  { "<leader>e",  group = "NvimTree" },
  { "<leader>ee", "<cmd>NvimTreeOpen | NvimTreeFindFile<CR>", desc = "NvimTreeFindFile" },
  { "<leader>ef", "<cmd>NvimTreeFindFile<CR>",                desc = "NvimTreeFindFile" },
  { "<leader>eq", "<cmd>NvimTreeClose<CR>",                   desc = "NvimTreeClose" },
  { "<leader>er", "<cmd>NvimTreeRefresh<CR>",                 desc = "NvimTreeRefresh" },
})

wk.add(
  {
    { "<leader>f",  group = "telescope" },
    { "<leader>fF", "<cmd>Telescope file_browser<CR>",                        desc = "file browser" },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",    desc = "find buffers" },
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "find files" },
    { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>",  desc = "live grep" },
  }
)

wk.add(
  {
    { "<leader>g",  group = "Git" },
    { "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>", desc = "git status files" },
  }
)
wk.add({
  { "<leader>l", group = "LSP" },
  {
    mode = { "n", "v" },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>",      desc = "vim.lsp.buf.declaration()" },
    { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>",           desc = "vim.lsp.buf.rename()" },
    { "<leader>l[", "<cmd>lua vim.diagnostic.goto_previous()<CR>", desc = "vim.diagnostic.goto_previous()" },
    { "<leader>l]", "<cmd>lua vim.diagnostic.goto_next()<CR>",     desc = "vim.diagnostic.goto_next()" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",      desc = "vim.lsp.buf.code_action()" },
    { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>",       desc = "vim.lsp.buf.definition()" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>",           desc = "vim.lsp.buf.format()" },
    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>",   desc = "vim.lsp.buf.implementation()" },
    { "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>",            desc = "vim.lsp.buf.hover()" },
    { "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>",    desc = "vim.diagnostic.open_float()" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>",       desc = "vim.lsp.buf.references()" },
    { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",  desc = "vim.lsp.buf.type_definition()" },
  },
}
)
