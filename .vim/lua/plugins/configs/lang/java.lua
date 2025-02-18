local function setup_keymaps(bufnr)
  local function buf_map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP関連のキーマップ
  buf_map('n', '<leader>Jo', function() require('jdtls').organize_imports() end, "[J]ava [O]rganize Imports")
  buf_map('n', '<leader>Jv', function() require('jdtls').extract_variable() end, "[J]ava Extract [V]ariable")
  buf_map('v', '<leader>Jv', function() require('jdtls').extract_variable(true) end, "[J]ava Extract [V]ariable")
  buf_map('n', '<leader>JC', function() require('jdtls').extract_constant() end, "[J]ava Extract [C]onstant")
  buf_map('v', '<leader>JC', function() require('jdtls').extract_constant(true) end, "[J]ava Extract [C]onstant")
  buf_map('n', '<leader>Jt', function() require('jdtls').test_nearest_method() end, "[J]ava [T]est Method")
  buf_map('n', '<leader>JT', function() require('jdtls').test_class() end, "[J]ava [T]est Class")

  -- Spring Boot関連のキーマップ
  buf_map('n', '<leader>Jr', function() require("springboot-nvim").boot_run() end, "[J]ava [R]un Spring Boot")
  buf_map('n', '<leader>Jc', function() require("springboot-nvim").generate_class() end, "[J]ava Create [C]lass")
  buf_map('n', '<leader>Ji', function() require("springboot-nvim").generate_interface() end, "[J]ava Create [I]nterface")
  buf_map('n', '<leader>Je', function() require("springboot-nvim").generate_enum() end, "[J]ava Create [E]num")
end

local function get_jdtls_config()
  return {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', vim.fn.expand('$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar'),
      '-configuration', vim.fn.expand('$MASON/share/jdtls/config_linux'),
      '-data', vim.fn.expand('~/.cache/jdtls-workspace/') .. vim.fn.getcwd():gsub("/", "_")
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),

    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          },
          hashCodeEquals = {
            useJava7Objects = true,
          },
        },
      },
    },
  }
end


return {
  {
    'mfussenegger/nvim-jdtls',
    cond = not env.is_vscode(),
    dependencies = {
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim',
    },
    ft = "java",
  },
  {
    'elmcgill/springboot-nvim',
    cond = not env.is_vscode(),
    ft = "java",
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-jdtls',
    },
    config = function()
      require("springboot-nvim").setup({})

      -- JDTLSのセットアップ
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local config = get_jdtls_config()
          config.on_attach = function(client, bufnr)
            setup_keymaps(bufnr)
            require('jdtls').setup_dap({ hotcodereplace = 'auto' })
          end
          require('jdtls').start_or_attach(config)
        end
      })
    end,
  }
}
