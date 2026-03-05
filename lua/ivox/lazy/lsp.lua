return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- completion
		"hrsh7th/nvim-cmp", -- engine
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim"
	},
	config = function()
		local cmp = require('cmp')
		local cmp_lsp = require('cmp_nvim_lsp')

		local lspconfig = require("lspconfig")
		local mason = require('mason').setup()
		local mason_lspconfig = require('mason-lspconfig')
		local capabilities = cmp_lsp.default_capabilities()

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"vimls",
				"rust_analyzer"
			},
			handlers = {
				function (server_name) -- whatever server you want
					require("lspconfig")[server_name].setup({
						capabilities = capabilities
					})
				end,
				["lua_ls"] = function ()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = {"vim"}
								}

							}
						}

					})
				end
			}
		})
		-- configuring the cmd (completion)
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(), -- quit the completion menu
				['<Enter>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" }
			}
		})
	end
}
