local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local coq_status_ok, coq = pcall(require, "coq")
if not coq_status_ok then
	return
end

local illuminate_status_ok, illuminate = pcall(require, "illuminate")
if not illuminate_status_ok then
	return
end

local servers = {
	"pyright",
	"yamlls",
	"jsonls",
	"sumneko_lua",
}

lsp_installer.setup({
	ensure_installed = servers,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		source = "always",
	},
	signs = false,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
})

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { silent = true, buffer = bufnr }
	--Mappings.
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
	-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, attach_opts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	-- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

	if
		client.name == "tsserver"
		or client.name == "html"
		or client.name == "jsonls"
		or client.name == "sumneko_lua"
	then
		client.resolved_capabilities.document_formatting = false
	end

	-- illuminate
	illuminate.on_attach(client)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
	}))
end
