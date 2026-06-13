return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "ts_ls", "jdtls", "pyright", "yamlls" },
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			opts.automatic_enable = true
			require("mason-lspconfig").setup(opts)

			local registry = require("mason-registry")
			local filetype_map = require("mason-lspconfig.mappings").get_filetype_map()
			local lspconfig_to_pkg = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mason-lsp-autoinstall", { clear = true }),
				desc = "Auto-install LSP server for filetype",
				callback = function(args)
					local servers = filetype_map[args.match]
					if not servers then
						return
					end
					for _, lsp_name in ipairs(servers) do
						local pkg_name = lspconfig_to_pkg[lsp_name]
						if pkg_name then
							local ok, pkg = pcall(registry.get_package, pkg_name)
							if ok and not pkg:is_installed() then
								pkg:install()
							end
						end
					end
				end,
			})
		end,
	},
}
