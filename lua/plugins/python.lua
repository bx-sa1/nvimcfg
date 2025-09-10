return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
            },
        },
    },
    {
        "Vigemus/iron.nvim",
        opts = {
            python = {
                command = { "python3" }, -- or { "ipython", "--no-autoindent" }
                -- format = common.bracketed_paste_python,
                block_dividers = { "# %%", "#%%" },
            },
        }
    },
}
