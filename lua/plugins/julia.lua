return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                julials = {},
            },
        },
    },
    {
        "Vigemus/iron.nvim",
        opts = {
            julia = {
                command = { "julia" }
            }
        }
    },
}
