local home = vim.fn.expand("$HOME")
require("chatgpt").setup({
    api_key_cmd = "gpg --decrypt " .. home .. "/secret.txt.gpg",
    actions_paths = {"~/dev/projects/dotfiles/.config/.vim/lua/plugins/config/chatgpt_actions.json"}
})
