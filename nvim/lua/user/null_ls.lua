local staus_ok, null_ls = pcall(require, "null-ls")
if not staus_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				-- on 0.8, you should use vim.lsp.buf.format instead
				callback = vim.lsp.buf.formatting_sync,
			})
		end
	end,
})
