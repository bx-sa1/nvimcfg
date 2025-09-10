return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                marksman = {},
                zk = {}
            }
        }
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                markdown = { "markdownlint-cli2" },
            },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
        keys = {
            {
                "<leader>tm",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "toggle [M]arkdown Preview",
            },
        },
    },
}
