return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
	    local autopairs = require("nvim-autopairs")
	    autopairs.setup({})

	    -- integración con cmp
	    local cmp = require("cmp")
	    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	    cmp.event:on(
		    "confirm_done",
		    cmp_autopairs.on_confirm_done()
	    )
    	
    end
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
}
