local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "?" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		vim.keymap.set("n", "[c", require("gitsigns").prev_hunk, { buffer = bufnr })
		vim.keymap.set("n", "]c", require("gitsigns").next_hunk, { buffer = bufnr })
		vim.keymap.set("n", "<space>gp", require("gitsigns").preview_hunk, { buffer = bufnr })
	end,
})
