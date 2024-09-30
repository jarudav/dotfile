return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {},
		opts = {
			servers = {
				-- pylyzer = {},
				pyright = {},
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
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
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
				scope = "cursor",
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

					if client.server_capabilities.documentHighlightProvider then
						vim.cmd([[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        ]])
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

					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = bufnr,
						callback = function()
							vim.diagnostic.open_float(nil, opts.diagnostic_float)
						end,
					})

					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end
						vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
					end
					local imap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end
						vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
					end

					nmap("gca", vim.lsp.buf.code_action, "Code Action")
					imap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
					nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				end,
			})

			for lsp, opt in pairs(opts.servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
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

	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		opts = {
			linters_by_ft = {
				fish = { "fish" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
