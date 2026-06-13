return{
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	confif = function()
		local config = require("nvim-treesitter")
		config.setup({
			ensure_installed = {"lua", "python", "javascript"}, 
			highlight = { ensure = true}, 
			indent = { ensure = true}, 
		})
	end
}
