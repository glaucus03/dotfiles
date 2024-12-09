vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require("which-key")
wk.register({
  c = {
    name = "ChatGPT",
    c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    A = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Act as" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
  },
}, { prefix = "<leader>" })
wk.register({
  ["<c-e>"] = {
    name = "NvimTree",
    ["<c-e>"] = { "<cmd>NvimTreeOpen | NvimTreeFindFile<CR>", "NvimTreeFindFile", mode = { "n" } },
    ["<c-q>"] = { "<cmd>NvimTreeClose<CR>", "NvimTreeClose", mode = { "n" } },
    ["<c-r>"] = { "<cmd>NvimTreeRefresh<CR>", "NvimTreeRefresh", mode = { "n" } },
    ["<c-f>"] = { "<cmd>NvimTreeFindFile<CR>", "NvimTreeFindFile", mode = { "n" } },
  }
})

wk.register({
  f = {
    name = "telescope",
    f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", 'find files', mode = { 'n' } },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", 'live grep', mode = { 'n' } },
    b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", 'find buffers', mode = { 'n' } },
    F = { "<cmd>Telescope file_browser<CR>", 'file browser', mode = { 'n' } },
  }
}, { prefix = "<leader>" })

wk.register({
  g = {
    name = "Git",
    s = { "<cmd>lua require('telescope.builtin').git_status()<CR>", 'git status files', mode = { 'n' } },
  }

}, { prefix = "<leader>" })

-- wk.register({
--   l = {
--     name = "LSP",
--     f = { "<Plug>(coc-format-selected)", "formatting", mode = { "n", "v" } },
--     r = { "<Plug>(coc-references)", "references", mode = { "n", "v" } },
--     d = { "<Plug>(coc-definition)", "definition", mode = { "n", "v" } },
--     i = { "<Plug>(coc-implementation)", "implementation", mode = { "n", "v" } },
--     t = { "<Plug>(coc-type_definition)", "type_definition", mode = { "n", "v" } },
--     R = { "<Plug>(coc-rename)", "rename", mode = { "n", "v" } },
--     D = { "<cmd>CocList diagnostics<CR>", "diagnostics", mode = { "n", "v" } },
--
--     ["]"] = { "<Plug>(coc-diagnostic-next)", "diagnostic goto_next", mode = { "n", "v" } },
--     ["["] = { "<Plug>(coc-diagnostic-prev)", "diagnostic goto_previous", mode = { "n", "v" } },
--     a = {
--       s = { "<Plug>(coc-codeaction-selected)", "code_action selected", mode = { "n", "v" } },
--       c = { "<Plug>(coc-codeaction-cursor)", "code_action cursor", mode = { "n" } },
--       S = { "<Plug>(coc-codeaction-source)", "code_action source", mode = { "n" } },
--       r = { "<Plug>(coc-codeaction-refactor)", "code_action refactor", mode = { "n" } },
--       R = { "<Plug>(coc-codeaction-refactor-selected)", "code_action refactor-selected", mode = { "n", "v" } },
--     }
--   },
-- }, { prefix= "<leader>" })
wk.register({
  l = {
    name = "LSP",
    k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "vim.lsp.buf.hover()", mode = { "n", "v" } },
    f = { "<cmd>lua vim.lsp.buf.format()<CR>", "vim.lsp.buf.format()", mode = { "n", "v" } },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "vim.lsp.buf.references()", mode = { "n", "v" } },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "vim.lsp.buf.definition()", mode = { "n", "v" } },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "vim.lsp.buf.declaration()", mode = { "n", "v" } },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "vim.lsp.buf.implementation()", mode = { "n", "v" } },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "vim.lsp.buf.type_definition()", mode = { "n", "v" } },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "vim.lsp.buf.rename()", mode = { "n", "v" } },
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "vim.lsp.buf.code_action()", mode = { "n", "v" } },
    o = { "<cmd>lua vim.diagnostic.open_float()<CR>", "vim.diagnostic.open_float()", mode = { "n", "v" } },
    ["]"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "vim.diagnostic.goto_next()", mode = { "n", "v" } },
    ["["] = { "<cmd>lua vim.diagnostic.goto_previous()<CR>", "vim.diagnostic.goto_previous()", mode = { "n", "v" } },

  },
}, { prefix = "<leader>" })
