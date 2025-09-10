return {
    {
        'davidgranstrom/scnvim',
        ft = 'supercollider',
        config = function()
            local scnvim = require 'scnvim'
            local map = scnvim.map
            local map_expr = scnvim.map_expr
            scnvim.setup {
                keymaps = {
                    ['<M-e>'] = map('editor.send_line', { 'i', 'n' }),
                    ['<C-e>'] = {
                        map('editor.send_block', { 'i', 'n' }),
                        map('editor.send_selection', 'x'),
                    },
                    ['<CR>'] = map('postwin.toggle'),
                    ['<M-CR>'] = map('postwin.toggle', 'i'),
                    ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),
                    ['<C-k>'] = map('signature.show', { 'n', 'i' }),
                    ['<F12>'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
                    ['<leader>ca'] = map('sclang.start'),
                    ['<leader>cr'] = map('sclang.recompile'),
                    ['<F1>'] = map_expr('s.boot'),
                    ['<F2>'] = map_expr('s.meter'),
                },
                editor = {
                    highlight = {
                        color = 'IncSearch',
                    },
                },
                snippet = {
                    engine = {
                        name = "luasnip",
                        options = {}
                    }
                }
            }
        end
    },
    {
        "echasnovski/mini.nvim",
        opts = {
            snippets = {
                function(_)
                    return require("scnvim/utils").get_snippets()
                end
            }
        }
    }
}
