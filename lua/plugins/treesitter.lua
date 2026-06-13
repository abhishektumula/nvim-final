return{
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	confif = function()
		local config = require("nvim-treesitter")
		config.setup({
			auto_install = true, 
			ensure_installed = {"lua", "python", "javascript", "react"},
			highlight = { ensure = true}, 
			indent = { ensure = true}, 
		})
	end
}
