return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {},
            },
        },
    },
    {
        "Vigemus/iron.nvim",
        opts = {
            sh = {
                command = { "bash" }
            },
        }
    },

}
