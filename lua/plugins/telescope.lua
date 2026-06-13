return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{ "<leader>f", ":Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fa", ":Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions", mode = { "n", "x" } },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
	},
}
