return {
	{
		"echasnovski/mini.surround",
		version = false,
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},
}
