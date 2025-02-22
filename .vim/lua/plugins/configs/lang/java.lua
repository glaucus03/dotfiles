local M = {}

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
  local mason_registry = require("mason-registry")
  local jdtls_pkg = mason_registry.get_package("jdtls")
  local jdtls_path = jdtls_pkg:get_install_path()
  local lombok_path = jdtls_path .. "/lombok.jar"

  -- Lombokが存在しない場合、ダウンロード
  if vim.fn.filereadable(lombok_path) == 0 then
    vim.fn.system(string.format(
      "curl -L %s -o %s",
      "https://projectlombok.org/downloads/lombok.jar",
      lombok_path
    ))
  end

  -- Java Debug Adapterの設定
  local bundles = {}
  local java_debug_pkg = mason_registry.get_package("java-debug-adapter")
  local java_test_pkg = mason_registry.get_package("java-test")

  vim.list_extend(bundles, vim.split(
    vim.fn.glob(java_debug_pkg:get_install_path() .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  ))
  vim.list_extend(bundles, vim.split(
    vim.fn.glob(java_test_pkg:get_install_path() .. "/extension/server/*.jar"),
    "\n"
  ))

  local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
  -- デバッグ出力
  if root_dir then
    vim.notify("JDTLS root directory: " .. root_dir, vim.log.levels.INFO)
  else
    vim.notify("No root directory found! Markers searched: " .. vim.inspect(root_markers), vim.log.levels.WARN)
    -- フォールバックとして現在のディレクトリを使用
    root_dir = vim.fn.getcwd()
  end

  local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace/') .. vim.fn.fnamemodify(root_dir, ':p:h:t')


  return {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "-Xmx2g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-javaagent:" .. lombok_path,
      "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      "-configuration", jdtls_path .. "/config_linux",
      "-data", workspace_dir
    },
    root_dir = root_dir,
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "interactive",
          runtimes = {
            {
              name = "JavaSE-21",
              path = vim.fn.expand("$JAVA_HOME"),
            }
          }
        },
        eclipse = {
          downloadSources = true,
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {
            "org.junit.jupiter.api.Assertions.*",
            "org.mockito.Mockito.*",
            "org.assertj.core.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
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
          useBlocks = true,
        },
        debug = {
          settings = {
            hotCodeReplace = "auto",
            enableRunDebugCodeLens = true,
            -- 単一メソッドのデバッグを強制
            forceBuildBeforeLaunch = true,
            useInstanceScope = true,
            showQualifiedNames = true,
            showStaticVariables = true,
            -- テスト実行時の設定
            enableTestFilter = true,
            filterStackTraces = true
          }
        }
      },
    },

    init_options = {
      bundles = bundles,
      extendedClientCapabilities = {
        resolveAdditionalTextEditsSupport = true,
        -- デバッグ機能の詳細設定
        classFileContentsSupport = true,
        generateToStringPromptSupport = true,
        hashCodeEqualsPromptSupport = true,
        advancedExtractRefactoringSupport = true,
        advancedOrganizeImportsSupport = true,
        executeClientCommandSupport = true,
        progressReportSupport = true,
        -- テストに関する拡張設定
        testSupport = true,
        shouldLanguageServerExitOnShutdown = true,
      }
    },
    -- init_options = {
    --   bundles = bundles,
    --   extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
    -- },
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
    config = function()
      -- JDTLSのセットアップ
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local config = get_jdtls_config()
          config.on_attach = function(client, bufnr)
            setup_keymaps(bufnr)
            require('jdtls').setup_dap({ hotcodereplace = 'auto' })
            require('jdtls.dap').setup_dap_main_class_configs()
            require('jdtls.setup').add_commands()
          end
          require('jdtls').start_or_attach(config)
        end
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim"
    },
    config = function()
      local nls = require("null-ls")
      local fmt = nls.builtins.formatting
      local dgn = nls.builtins.diagnostics
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local mason_registry = require("mason-registry")
      local jdtls_pkg = mason_registry.get_package("jdtls")
      local jdtls_path = jdtls_pkg:get_install_path()
      local checkstyle_path = jdtls_path .. "/google-checks.xml"

      nls.setup({
        sources = {
          fmt.google_java_format.with({
            extra_args = {
              -- "--aosp" --indent4
            },
          }),

        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end
            })
          end
        end
      })
    end

  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- require('lint').linters_by_ft = {
      --   java = { 'checkstyle' },
      -- }
      vim.api.nvim_create_autocmd({
        "BufWritePost"
      }, {
        callback = function()
          require("lint").try_lint()
          require("lint").try_lint("cspell")
        end
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Simple configuration to attach to remote java debug process
      -- Taken directly from https://github.com/mfussenegger/nvim-dap/wiki/Java
    end,
  }
}
