return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- completion
		"hrsh7th/nvim-cmp", -- engine
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

		local lspconfig = require("lspconfig")
		local mason = require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = cmp_lsp.default_capabilities()

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"vimls",
				"rust_analyzer",
				"clangd",
				"gopls",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"angularls",
			},
			handlers = {
				function(server_name) -- whatever server you want
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
				["html"] = function()
					lspconfig.html.setup({
						capabilities = capabilities,
						filetypes = { "html" }, -- no htmlangular
					})
				end,
				["angularls"] = function()
					lspconfig.angularls.setup({
						capabilities = capabilities,
						cmd = {
							"ngserver",
							"--stdio",
							"--tsProbeLocations",
							"",
							"--ngProbeLocations",
							"",
						},
						filetypes = { "html", "htmlangular", "typescript" },
					})
				end,
			},
		})
		-- configuring the cmd (completion)
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(), -- quit the completion menu
				["<Enter>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(e)
				local opts = { buffer = e.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
	end,
	vim.diagnostic.config({
		signs = false,
		underline = true,
	}),
}
