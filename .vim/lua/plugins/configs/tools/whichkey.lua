return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")

      -- default keymap
      wk.add({
        {
          "<C-a>",
          function()
            require("dial.map").manipulate("increment", "normal")
          end
          ,
          desc = "Increment"
        },
        {
          "<C-x>",
          function()
            require("dial.map").manipulate("decrement", "normal")
          end
          ,
          desc = "Decrement"
        },
      })

      -- leader keymap


      wk.add({
        { "<leader>c", group = "Convert Commands" },
        {
          mode = { "n", "v" },

          {
            "<leader>cgi",
            function()
              require("dial.map").manipulate("increment", "gnormal")
            end
            ,
            desc = "Increment"
          },
          {
            "<leader>cgd",
            function()
              require("dial.map").manipulate("decrement", "gnormal")
            end
            ,
            desc = "Decrement"
          },
        },
      })


      wk.add({
        { "<leader>l", group = "LSP" },
        {
          mode = { "n", "v" },
          { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>",                           desc = "vim.lsp.buf.rename()" },
          { "<leader>l,", "<cmd>lua vim.diagnostic.goto_previous()<CR>",                 desc = "vim.diagnostic.goto_previous()" },
          { "<leader>l.", "<cmd>lua vim.diagnostic.goto_next()<CR>",                     desc = "vim.diagnostic.goto_next()" },
          { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",                      desc = "vim.lsp.buf.code_action()" },
          { "<leader>ld", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", desc = "move definitions under cursor" },
          { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>",                           desc = "vim.lsp.buf.format()" },
          { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>",                   desc = "vim.lsp.buf.implementation()" },
          { "<leader>lk", "<cmd>lua vim.lsp.buf.hover()<CR>",                            desc = "vim.lsp.buf.hover()" },
          { "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>",                    desc = "vim.diagnostic.open_float()" },
          { "<leader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>",  desc = "show references" },
          { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",                   desc = "show signature help" },
          { "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>",                  desc = "move type definitions" },
        },
        {
          { "<leader>lt",  group = "LSP: Troubles" },
          mode = { "n", "v" },
          { "<leader>ltd", "<cmd>Trouble diagnostics toggle<CR>",                        desc = "Diagnostics (Trouble)" },
          { "<leader>ltb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
          { "<leader>lts", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
          { "<leader>ltl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
          { "<leader>lti", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
          { "<leader>ltq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
        },
      }
      )

      if not vim.g.vscode then
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
            { "<leader>fr", "<cmd>Telescope file_browser<CR>",                                       desc = "file browser" },
            { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",                   desc = "find buffers" },
            { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>",                desc = "find files" },
            { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>",                 desc = "live grep" },
            { "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<CR>",                  desc = "show commands" },
            { "<leader>fm", "<cmd>lua require('telescope.builtin').marks()<CR>",                     desc = "show marks" },
            { "<leader>fv", "<cmd>lua require('telescope.builtin').registers()<CR>",                 desc = "show registers" },
            { "<leader>fy", "<cmd>lua require('neoclip.fzf')({'a', 'star', 'plus', 'unnmaed'})<CR>", desc = "yank" },
            { mode = { "t" }, { "<c-q>", "<cmd>ToggleTermToggleAll<CR>", desc = "close toggle" } }

          }
        )
        wk.add(
          {
            { "<leader>g",   group = "Git" },
            { "<leader>gg",  "<cmd>LazyGit<CR>",                                       desc = "open lazygit" },
            { "<leader>gs",  "<cmd>lua require('telescope.builtin').git_status()<CR>", desc = "git status files" },
            { "<leader>gb",  "<cmd>BlamerToggle<CR>",                                  desc = "show git blame" },
            { "<leader>gvo", "<cmd>DiffviewOpen<CR>",                                  desc = "show git diff" },
            { "<leader>gvo", "<cmd>DiffviewClose<CR>",                                 desc = "close git diff" },
          }
        )

        wk.add({
          { "<leader>s", group = "Image Commands" },
          {
            mode = { "v" },
            {
              "<leader>sc",
              function()
                require("nvim-silicon").clip()
              end
              ,
              desc = "Silicon save clipboard"
            },
            {
              "<leader>sf",
              function()
                require("nvim-silicon").file()
              end
              ,
              desc = "Silicon save file"
            },
          },
        })

        wk.add({
          { "<leader>m",  group = "Move Commands" },
          { "<leader>mh", "<cmd>HopWord<CR>",     desc = "HopWord" },
        })
      else
        vim.keymap.set("n", "<leader>fb", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
        vim.keymap.set("n", "H", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
        vim.keymap.set("n", "L", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")
      end
    end,
    dependencies = {
      'echasnovski/mini.icons',
    },
  },

}
