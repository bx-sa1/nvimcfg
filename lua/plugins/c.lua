return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {
					on_attach = function()
						vim.keymap.set(
							"n",
							"grs",
							"<cmd>LspClangdSwitchSourceHeader<cr>",
							{ desc = "ClangD: Switch Source and Header" }
						)
					end,
				},
			},
		},
	},
	{
		"p00f/clangd_extensions.nvim",
		keys = {
			{
				"<localleader>s",
				"<cmd>ClangdSwitchSourceHeader<cr>",
				"n",
				{ "c", "cpp", "objc", "objcpp", "cuda" },
				desc = "Clangd: Switch Source and Header",
			},
		},
	},
}
