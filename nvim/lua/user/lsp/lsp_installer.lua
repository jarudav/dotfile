local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
		keymaps = {
			-- Keymap to expand a server in the UI
			toggle_server_expand = "<CR>",
			-- Keymap to install a server
			install_server = "i",
			-- Keymap to reinstall/update a server
			update_server = "u",
			-- Keymap to update all installed servers
			update_all_servers = "U",
			-- Keymap to uninstall a server
			uninstall_server = "X",
		},
	},
})

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.lsp_handler").on_attach,
		capabilities = require("user.lsp.lsp_handler").capabilities,
	}
	server:setup(opts)
end)
