local M = {}

function M.setup()
  -- プラグインドキュメント生成
  vim.api.nvim_create_user_command("GeneratePluginDocs", function()
    require("plugins.tools.doc_generator").generate_docs()
  end, {})

  -- メモ関連のコマンド
  vim.api.nvim_create_user_command('Memo', function(opts)
    vim.cmd.edit(vim.fn.expand("~/dev/memo/" .. os.date("%Y%m%d") .. "memo.md"))
  end, {})

  vim.api.nvim_create_user_command('Todo', function(opts)
    vim.cmd.edit(vim.fn.expand("~/dev/Todo.md"))
  end, {})

  vim.api.nvim_create_user_command('CdVimSetting', function(opts)
    vim.cmd.cd(vim.fn.expand("~/.vim"))
  end, {})
end

M.setup()

return M
