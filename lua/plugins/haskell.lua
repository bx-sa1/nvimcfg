return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                hls = {
                    filetypes = { "haskell", "lhaskell", "cabal" },
                },
            },
        },
    },
    {
        "Vigemus/iron.nvim",
        opts = {
            haskell = {
                command = function(meta)
                    local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
                    return { 'cabal', 'repl', filename }
                end,
                format = function(lines)
                    local common = require("iron.fts.common")
                    if #lines == 1 then
                        return { lines[1] .. common.cr }
                    else
                        local new = { "{:" .. lines[1] }
                        for line = 2, #lines do
                            table.insert(new, lines[line])
                        end

                        table.insert(new, ":}" .. common.cr)

                        return new
                    end
                end
            }
        }
    }
}
