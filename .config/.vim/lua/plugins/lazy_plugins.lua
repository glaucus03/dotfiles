return {
	-- layout
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("plugins.config.nightfox")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- {
	--   'christianchiarulli/nvcode-color-schemes.vim',
	--   config = function()
	--     --require('plugins.config.nvcode-color-schemes')
	--     vim.cmd('colorscheme ' .. 'xoria')
	--   end,
	-- },
	-- {
	--   'antonk52/lake.nvim',
	--   config = function()
	--     vim.cmd('colorscheme ' .. 'deep-space')
	--   end,
	-- },
	-- windows management
	{
		"simeji/winresizer",
		init = function()
			require("plugins.config.winresizer")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = {
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeFocus",
			"NvimTreeToggle",
		},
		config = function()
			require("plugins.config.nvim-tree")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugins.config.lualine")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- config = function()
		-- end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.config.telescope")
		end,
	},
	-- code layout
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.config.nvim-treesitter")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.config.nvim-colorizer")
		end,
	},
	-- session
	{
		"rmagatti/auto-session",
		config = function()
			require("plugins.config.auto-session")
		end,
	},
	-- git
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.config.lazygit")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("plugins.config.diffview")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.config.toggleterm")
		end,
	},
	{
		"APZelos/blamer.nvim",
		config = function()
			require("plugins.config.blamer")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.config.gitsigns")
		end,
	},
	-- edit action
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.config.comment")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("plugins.config.which-key")
		end,
		dependencies = {
			"echasnovski/mini.icons",
		},
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.config.chatgpt")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- edit viewing
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			require("plugins.config.vim-matchup")
		end,
	},
	-- {
	--   'lukas-reineke/indent-blankline.nvim',
	--   main = "ibl",
	--   config = function()
	--     require('plugins.config.indent-blankline')
	--   end,
	-- },
	-- lsp
	-- {
	--   'neoclide/coc.nvim',
	--   config = function()
	--     require('plugins.config.coc-nvim')
	--   end,
	--   branch = "release",
	-- },
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.config.mason")
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	-- dap
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("plugins.config.nvim-dap")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.config.nvim-dap")
		end,
	},
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.config.nvim-cmp")
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-buffer",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-path",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-vsnip",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "ModeChanged",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-calc",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-emoji",
		event = "InsertEnter",
	},
	{
		"onsails/lspkind.nvim",
		event = "InsertEnter",
	},
	{
		"hrsh7th/vim-vsnip",
		event = "InsertEnter",
	},
	{
		"hrsh7th/vim-vsnip-integ",
		event = "InsertEnter",
	},
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	},
	-- {
	--   'rinx/cmp-skkeleton',
	--   dependencies = {
	--     {
	--       'vim-skk/skkeleton',
	--       dependencies = {
	--         'vim-denops/denops.vim',
	--       },
	--       config = function()
	--         require('plugins.config.skkeleton')
	--       end,
	--     }
	--   }
	-- },
	-- {
	--   'delphinus/skkeleton_indicator.nvim',
	--   config = function()
	--     require('plugins.config.skkeleton-indicator')
	--   end
	-- },

	-- debugger
	-- {
	--   'mfussenegger/nvim-dap',
	--   config = function()
	--     require('plugins.config.nvim-dap')
	--   end,
	-- },
	-- {
	--   'rcarriga/nvim-dap-ui',
	--   config = function()
	--     require('plugins.config.nvim-dap-ui')
	--   end,
	-- },
	-- {
	--   'theHamsta/nvim-dap-virtual-text',
	--   config = function()
	--     require('plugins.config.nvim-dap-virtual-text')
	--   end,
	-- },

	-- dev
	-- {
	--   "iamcco/markdown-preview.nvim",
	--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	--   ft = { "markdown" },
	--   build = function() vim.fn["mkdp#util#install"]() end,
	-- },
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("plugins.config.flutter-tools")
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},
}
