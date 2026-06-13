return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				rust = { "rustfmt" },
				go = { "gofumpt", "golines" },
				sh = { "shfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			local registry = require("mason-registry")

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("mason-formatter-autoinstall", { clear = true }),
				desc = "Auto-install formatter for filetype",
				callback = function(args)
					local formatters = opts.formatters_by_ft[args.match]
					if not formatters then
						return
					end
					for _, name in ipairs(formatters) do
						local ok, pkg = pcall(registry.get_package, name)
						if ok and not pkg:is_installed() then
							pkg:install()
						end
					end
				end,
			})

			vim.keymap.set("n", "<leader>gf", function()
				require("conform").format({ async = false, lsp_fallback = true })
			end, { desc = "Format buffer" })
		end,
	},
}
