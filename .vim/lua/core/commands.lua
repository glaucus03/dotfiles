local M = {}

function M.setup()
  -- プラグインドキュメント生成
  vim.api.nvim_create_user_command("GeneratePluginDocs", function()
    require("plugins.tools.doc_generator").generate_docs()
  end, {})

  -- メモ関連のコマンド
  vim.api.nvim_create_user_command('CmMemo', function(opts)
    vim.cmd.edit(vim.fn.expand("~/dev/memo/" .. os.date("%Y%m%d") .. "memo.md"))
  end, {})

  vim.api.nvim_create_user_command('CmTodo', function(opts)
    vim.cmd.edit(vim.fn.expand("~/dev/Todo.md"))
  end, {})

  vim.api.nvim_create_user_command('CmCdVimSetting', function(opts)
    vim.cmd.cd(vim.fn.expand("~/.vim"))
  end, {})

  vim.api.nvim_create_user_command('CmReplaceCrlfToLf', function(opts)
    vim.cmd([[%s/\r//ge]])
  end, {})
end

M.setup()

return M
