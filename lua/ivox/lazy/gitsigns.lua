return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			-- this allows me to know who made each commit
			current_line_blame = true,
		})
	end,
}
