return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			auto_install = true,
			ensure_installed = { "lua", "python", "javascript", "typescript" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
