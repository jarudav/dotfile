return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {},
		opts = {
			servers = {
				pyright = {
					pyright = {
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							ignore = { "*" },
						},
					},
				},
				ruff = {},
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						completion = { callSnippet = "Replace" },
						telemetry = { enable = false },
					},
				},
			},
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { current_line = true, spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			},
			diagnostic_float = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "line",
			},
		},
		config = function(_, opts)
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()

			for severity, icon in pairs(opts.diagnostics.signs.text) do
				local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Lsp Actions",
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client:supports_method("textDocument/completion") then
						vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
					end

					if client.server_capabilities.documentHighlightProvider then
						-- vim.cmd([[
						--   hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
						--   hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
						--   hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
						--   ]])
						vim.api.nvim_create_augroup("lsp_document_highlight", {
							clear = false,
						})
						vim.api.nvim_clear_autocmds({
							buffer = bufnr,
							group = "lsp_document_highlight",
						})
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = "lsp_document_highlight",
							buffer = bufnr,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							group = "lsp_document_highlight",
							buffer = bufnr,
							callback = vim.lsp.buf.clear_references,
						})
					end

					vim.keymap.set("n", "<space>e", function()
						vim.diagnostic.open_float(nil, opts.diagnostic_float)
					end)

					vim.keymap.set("i", "<C-k>", function()
						vim.lsp.buf.signature_help()
					end)
				end,
			})

			for lsp, opt in pairs(opts.servers) do
				vim.lsp.enable(lsp)
				vim.lsp.config(lsp, {
					-- capabilities = capabilities,
					settings = opt,
				})
			end
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				python = { "ruff_format", "ruff_organize_imports" },
				javascript = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
