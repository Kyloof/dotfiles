-- ====================
-- 		  Globals
-- ====================

vim.g.have_nerd_font = true
vim.g.mapleader = " "


-- ====================
-- 		  Options
-- ====================

vim.o.autoindent = true
vim.o.clipboard = "unnamedplus"
vim.o.confirm = true
vim.o.number = true
vim.o.pumheight = 5
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4


-- ====================
-- 	     Plugins
-- ====================

local gh = function(path) return "https://github.com/" .. path end

vim.pack.add {
	-- Core
	gh("nvim-treesitter/nvim-treesitter"),
	gh("xzbdmw/colorful-menu.nvim"), -- treesitter + colors for completion
	gh("nvim-lua/plenary.nvim"),
	gh("folke/snacks.nvim"),
	-- Completion
	gh("Saghen/blink.cmp"),
	gh("Saghen/blink.lib"),
	-- LSP
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("seblyng/roslyn.nvim"),
	-- Formatting
	gh("stevearc/conform.nvim"),
	-- Highlighting
	gh("phelipetls/vim-hugo"),
	-- UI
	gh("sainnhe/gruvbox-material"),
	gh("stevearc/dressing.nvim"),
	gh("stevearc/aerial.nvim"), -- A code outline window for navigation
	-- Dev
	gh("nvim-flutter/flutter-tools.nvim"),
	gh("jlcrochet/vim-razor"),
	gh("Aietes/esp32.nvim"),
	-- Notetaking
	gh("kaarmu/typst.vim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	-- File Exploration
	gh("stevearc/oil.nvim"),
}


-- ====================
-- 	  Plugin Config
-- ====================

-- ====================
-- 	  	   Core
-- ====================

-- nvim-treesitter
require("nvim-treesitter").setup {
	install_dir = vim.fn.stdpath("data") .. "/site",
	highlight = { enable = true },
}

-- Injections

-- Completion
--
-- blink.cmp
local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
	keymap = {
		preset = "none",
		["<Tab>"] = { "select_and_accept", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
	},
	completion = {
		documentation = {
			auto_show = false,
			window = { border = "rounded" },
		},
		menu = {
			border = nil,
			draw = {
				-- We don't need label_description now because label and label_description are already
				-- combined together in label by colorful-menu.nvim.
				columns = { { "kind_icon" }, { "label", gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
		ghost_text = {
			enabled = true
		},
	}
})

-- QoL
--
-- Snacks
require("snacks").setup({})

-- ====================
-- 	  	   LSP
-- ====================
--
-- mason
require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

require("mason-lspconfig").setup()

-- Diagnostics
vim.diagnostic.open_float({ focusable = true })
vim.diagnostic.config({
	float = {
		border = "single"
	}
})

-- Capabilities
vim.lsp.config('*', {
	capabilities = cmp.get_lsp_capabilities(),
})

-- DartLS
vim.lsp.config("dartls", {
	cmd = { "dart", 'language-server', '--protocol=lsp' }
})

-- Roslyn
vim.lsp.config("roslyn", {
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
		},
	},
})

vim.filetype.add({
	extension = {
		cshtml = 'razor',
		razor = 'razor',
	},
})

vim.treesitter.language.register('html', 'razor')

-- lua_ls
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		}
	}
})

-- ====================
-- 	  	   Dev
-- ====================
require("esp32").setup()

vim.lsp.config("clangd", require("esp32").lsp_config())
vim.lsp.enable("clangd")

-- ====================
-- 	  	 Formatter
-- ====================
require("conform").setup({
	formatters_by_ft = {
		-- lua = { "stylua" },
		html = { "prettier" },
		htmlhugo = { "prettier" },
		markdown = { "prettier" },
		c = { "clang" },

		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 2500,
		lsp_fallback = true,
	},
})

-- ====================
-- 	  	 	UI
-- ====================
--
-- gruvbox-material
vim.cmd.colorscheme("gruvbox-material")

-- Dev
--
-- Flutter-tools
require("flutter-tools").setup({})

-- oil
require("oil").setup()

require("aerial").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})

vim.keymap.set("n", "<leader>n", "<cmd>AerialToggle!<CR>")


-- ====================
-- 		  Keymaps
-- ====================

-- Hover
vim.keymap.set('n', 'K', function()
	vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
end, { desc = "Hover documentation" })

-- Diagnostic errors
vim.keymap.set("n", "gl", vim.diagnostic.open_float)

-- Browse files with oil.nvim
vim.keymap.set("n", "<Bslash>", "<cmd>Oil<cr>", { desc = "Open Oil" })





-- ====================
-- 		 Autocmds
-- ====================
local augroup = vim.api.nvim_create_augroup("keymaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "typst",
	callback = function()
		vim.keymap.set('n', '<leader>l', function()
			-- Parametry nvim_put:
			-- 1. Tabela z liniami tekstu do wstawienia
			-- 2. Typ wstawiania: 'l' (nowa linia), 'c' (w miejscu kursora)
			-- 3. Czy wstawić ZA kursorem (true/false)
			-- 4. Czy przenieść kursor na koniec wstawionego tekstu (true/false)
			vim.api.nvim_put({ '#line(length: 100%)' }, 'c', true, true)
		end, { buffer = true, desc = "Insert line" })
		vim.keymap.set('n', '<leader>a', function()
			vim.api.nvim_put({ '$=>$' }, 'c', true, true)
		end, { buffer = true, desc = "Insert arrow" })
	end,
})
-- Autoformat
--
-- ====================
-- 		Injections
-- ====================
