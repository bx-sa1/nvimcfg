return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                features = "all",
                                allTargets = true,
                                extraArgs = { "--all" },
                            },
                            -- Add clippy lints for Rust.
                            checkOnSave = true,
                            check = {
                                command = "clippy",
                                extraArgs = { "--", "-W", "clippy::pedantic" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                        },
                    },
                },
            }
        }
    }
}
