local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status then
	return
end

local servers = {
	"pyright",
	"sumneko_lua",
}

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	--Mappings.
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
end

local handlers = {
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = false,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
	}),
}

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
	if lsp == "sumneko_lua" then
		lspconfig[lsp].setup({
			on_attach = on_attach,
			handlers = handlers,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
	else
		lspconfig[lsp].setup({
			on_attach = on_attach,
			handlers = handlers,
			capabilities = capabilities,
		})
	end
end
