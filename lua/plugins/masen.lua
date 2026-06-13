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
			local lspconfig_to_pkg = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package

			local primary_servers = {
				lua = "lua_ls",
				python = "pyright",
				javascript = "ts_ls",
				typescript = "ts_ls",
				javascriptreact = "ts_ls",
				typescriptreact = "ts_ls",
				go = "gopls",
				rust = "rust_analyzer",
				java = "jdtls",
				yaml = "yamlls",
				json = "jsonls",
				html = "html",
				css = "cssls",
				bash = "bashls",
				sh = "bashls",
				markdown = "marksman",
				vue = "vue_ls",
				svelte = "svelte",
			}

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mason-lsp-autoinstall", { clear = true }),
				desc = "Auto-install LSP server for filetype",
				callback = function(args)
					local lsp_name = primary_servers[args.match]
					if not lsp_name then
						return
					end
					local pkg_name = lspconfig_to_pkg[lsp_name]
					if pkg_name then
						local ok, pkg = pcall(registry.get_package, pkg_name)
						if ok and not pkg:is_installed() then
							pkg:install()
						end
					end
				end,
			})
		end,
	},
}
