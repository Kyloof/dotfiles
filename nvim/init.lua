-- ====================
-- 		  Globals
-- ====================
vim.g.have_nerd_font = true
vim.g.mapleader = " "


-- ====================
-- 		  Options
-- ====================
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.pumheight = 5
vim.o.autoindent = true


local gh = function(path) return "https://github.com/" .. path end

-- ====================
-- 		  Plugins
-- ====================
vim.pack.add {
	-- Core
	gh("nvim-treesitter/nvim-treesitter"),
	gh("xzbdmw/colorful-menu.nvim"), -- treesitter + colors for completion
	gh("nvim-lua/plenary.nvim"),
	-- LSP
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	-- UI
	gh("sainnhe/gruvbox-material"),
	gh("stevearc/dressing.nvim"),
	-- Completion
	gh("Saghen/blink.cmp"),
	gh("Saghen/blink.lib"),
	-- Flutter
	gh("nvim-flutter/flutter-tools.nvim"),
}

-- nvim-treesitter
require("nvim-treesitter").setup {
  install_dir = vim.fn.stdpath("data") .. "/site"
}

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

-- gruvbox-material
vim.cmd.colorscheme("gruvbox-material")

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP
vim.lsp.config('*', {
     capabilities = cmp.get_lsp_capabilities(),
})

vim.diagnostic.open_float({ focusable = true })
vim.diagnostic.config({
	float = {
		border = "single"
	}
})

-- Include vim workspace library 
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

vim.lsp.config("dartls", {
	cmd = { "dart", 'language-server', '--protocol=lsp' }
})

-- Flutter-tools
require("flutter-tools").setup({})

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3 -- Tree style

-- ====================
-- 		  Keymaps
-- ====================
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
end, { desc = "Hover documentation" })

vim.keymap.set("n", "gl", vim.diagnostic.open_float)


-- ====================
-- 		 Autocmds
-- ====================


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.dart",
  callback = function()
    vim.lsp.buf.format()
  end,
})

