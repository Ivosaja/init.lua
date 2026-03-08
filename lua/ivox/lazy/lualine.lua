return {

	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "gruvbox",
			},
			sections = {
				-- left section
				lualine_a = {
					{
						"mode",
						icon = "",
					},
				},
				-- right section
				lualine_z = {
					{
						"datetime",
						style = "%H:%M",
						icon = "",
					},
				},
			},
		})
	end,
}
