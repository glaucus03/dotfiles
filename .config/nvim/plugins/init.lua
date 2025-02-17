require("lazy").setup({
  { import = "plugins.configs.ui" },
  { import = "plugins.configs.coding" },
  { import = "plugins.configs.tools" },
}, {
  install = {
    colorscheme = { "nightfox" }, -- お好みのカラースキームに変更
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})
