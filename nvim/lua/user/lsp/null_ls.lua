local staus_ok, null_ls = pcall(require, "null-ls")
if not staus_ok then
	return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local sources = {
	formatting.prettier,
	formatting.black,
	formatting.isort,
	formatting.stylua,
	formatting.fish_indent,
}
null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            ]])
		end
	end,
})
