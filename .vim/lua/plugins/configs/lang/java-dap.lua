return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui"
    },
    config = function()
      -- 既存のJaCoCo設定
      require("jacoco").setup({
        -- JaCoCoの設定
        report_paths = {
          -- レポートパスの指定（プロジェクトによって異なる場合があります）
          -- Mavenプロジェクトの場合
          "target/site/jacoco/jacoco.xml",
          -- Gradleプロジェクトの場合
          "build/reports/jacoco/test/jacocoTestReport.xml",
        },
        display_method = "inline", -- 行番号の色を変更する方法
        -- カバレッジデータを表示するための設定
        signs = {
          covered = { text = "✓", texthl = "JacocoCovered" },
          missed = { text = "✘", texthl = "JacocoMissed" },
          partial = { text = "◑", texthl = "JacocoPartial" },
        },

        -- カスタムコマンド
        -- Mavenプロジェクトの場合のコマンド
        maven_command = "mvn test jacoco:report",
        -- Gradleプロジェクトの場合のコマンド
        gradle_command = "./gradlew test jacocoTestReport",

        -- プロジェクトタイプの自動検出（pom.xmlかbuild.gradleのどちらがあるか）
        auto_detect_project_type = true,
      })

      vim.api.nvim_set_hl(0, "JacocoCovered", { fg = "#00FF00" }) -- カバー済み: 緑色
      vim.api.nvim_set_hl(0, "JacocoMissed", { fg = "#FF0000" })  -- 未カバー: 赤色
      vim.api.nvim_set_hl(0, "JacocoPartial", { fg = "#FFFF00" }) -- 部分カバー: 黄色

      -- カバレッジハイライトの色設定
      vim.api.nvim_set_hl(0, "JacocoCoveredLine", { fg = "#00FF00", bold = true })
      vim.api.nvim_set_hl(0, "JacocoMissedLine", { fg = "#FF0000", bold = true })
      vim.api.nvim_set_hl(0, "JacocoPartialLine", { fg = "#FFFF00", bold = true })
      
      -- Spring Boot用のデバッグ設定
      local dap = require('dap')
      
      -- Java用デバッグ設定
      dap.configurations.java = dap.configurations.java or {}
      
      -- Spring Boot通常デバッグ設定
      table.insert(dap.configurations.java, {
        type = 'java',
        request = 'launch',
        name = 'Spring Boot: Debug',
        mainClass = '${file}',
        projectName = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        args = '',
        vmArgs = '-Dspring.profiles.active=local -Dspring.output.ansi.enabled=always -Ddebug',
        env = {
          SPRING_APPLICATION_JSON = [[{
            "logging.level.org.springframework": "DEBUG"
          }]]
        },
        noDebug = false,
      })
      
      -- Spring Bootリモートデバッグ設定
      table.insert(dap.configurations.java, {
        type = 'java',
        request = 'attach',
        name = 'Spring Boot: Remote Debug',
        hostName = 'localhost',
        port = 5005,
      })
      
      -- デバッグコマンドのユーティリティ関数
      local function detect_spring_boot_main_class()
        -- プロジェクトルート検出
        local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
        if not root_dir then
          vim.notify("プロジェクトルートが見つかりません", vim.log.levels.ERROR)
          return nil
        end
        
        -- プロジェクトタイプの検出
        local is_maven = vim.fn.filereadable(root_dir .. '/pom.xml') == 1
        local is_gradle = vim.fn.filereadable(root_dir .. '/build.gradle') == 1 or vim.fn.filereadable(root_dir .. '/build.gradle.kts') == 1
        
        if not (is_maven or is_gradle) then
          vim.notify("MavenまたはGradleプロジェクトではありません", vim.log.levels.ERROR)
          return nil
        end
        
        -- MainクラスのGlob検索パターン
        local pattern = "**/*Application.java"
        local main_files = vim.fn.glob(root_dir .. "/" .. pattern, false, true)
        
        -- 見つからない場合は手動で指定させる
        if #main_files == 0 then
          local main_class = vim.fn.input("Spring Boot Main Class: ", "", "file")
          return main_class
        elseif #main_files == 1 then
          -- ファイルパスからクラス名に変換（パッケージ名を含む）
          local file_path = main_files[1]
          local rel_path = file_path:sub(#root_dir + 2) -- rootからの相対パス
          
          -- src/main/javaがある場合はそれ以降を取得
          local java_src_prefix = "src/main/java/"
          local class_path = rel_path
          if rel_path:find(java_src_prefix) then
            class_path = rel_path:sub(#java_src_prefix + 1)
          end
          
          -- .javaを削除し、/を.に置換
          local class_name = class_path:gsub("%.java$", ""):gsub("/", ".")
          return class_name
        else
          -- 複数見つかった場合、選択肢を提示
          vim.ui.select(main_files, {
            prompt = "Select Spring Boot Main Class:",
            format_item = function(item)
              return vim.fn.fnamemodify(item, ":t")
            end
          }, function(file_path)
            if not file_path then return nil end
            
            local rel_path = file_path:sub(#root_dir + 2)
            local java_src_prefix = "src/main/java/"
            local class_path = rel_path
            if rel_path:find(java_src_prefix) then
              class_path = rel_path:sub(#java_src_prefix + 1)
            end
            
            return class_path:gsub("%.java$", ""):gsub("/", ".")
          end)
        end
      end
      
      -- Spring Bootアプリを起動するコマンド
      local function spring_boot_run(debug_mode)
        local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
        if not root_dir then
          vim.notify("プロジェクトルートが見つかりません", vim.log.levels.ERROR)
          return
        end
        
        local is_maven = vim.fn.filereadable(root_dir .. '/pom.xml') == 1
        local is_gradle = vim.fn.filereadable(root_dir .. '/build.gradle') == 1 or vim.fn.filereadable(root_dir .. '/build.gradle.kts') == 1
        
        local cmd
        if debug_mode then
          if is_maven then
            cmd = 'mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"'
          else
            cmd = './gradlew bootRun --debug-jvm'
          end
        else
          if is_maven then
            cmd = 'mvn spring-boot:run -Dspring.profiles.active=local'
          else
            cmd = './gradlew bootRun --args="--spring.profiles.active=local"'
          end
        end
        
        -- 実行コマンドをターミナルで開く
        vim.cmd('tabnew | terminal ' .. cmd)
        vim.cmd('startinsert')
        
        -- デバッグモードの場合、リモートデバッガを接続
        if debug_mode then
          vim.defer_fn(function()
            require('dap').run({
              type = 'java',
              request = 'attach',
              name = 'Attach to Spring Boot',
              hostName = 'localhost',
              port = 5005,
            })
          end, 2000) -- 2秒待ってからデバッガを接続
        end
      end
      
      -- DAPのメインコマンド登録
      vim.api.nvim_create_user_command('SpringBootRun', function()
        spring_boot_run(false)
      end, { desc = 'Run Spring Boot Application' })
      
      vim.api.nvim_create_user_command('SpringBootDebug', function()
        spring_boot_run(true)
      end, { desc = 'Debug Spring Boot Application' })
      
      -- 直接デバッグを開始するコマンド（コードレンズを使わない場合）
      vim.api.nvim_create_user_command('SpringBootDebugStart', function()
        local main_class = detect_spring_boot_main_class()
        if not main_class then
          vim.notify("Spring BootのMainクラスが見つかりません", vim.log.levels.ERROR)
          return
        end
        
        -- 設定を更新して起動
        for i, config in ipairs(dap.configurations.java) do
          if config.name == "Spring Boot: Debug" then
            dap.configurations.java[i].mainClass = main_class
            break
          end
        end
        
        dap.run(dap.configurations.java[1]) -- Spring Boot: Debug設定を使用
      end, { desc = 'Start Spring Boot Debug Session' })
    end,
  }
}
