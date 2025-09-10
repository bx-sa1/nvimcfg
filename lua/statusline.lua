local modes = {
    ["n"] = { str = "NORMAL" },
    ["v"] = { str = "VISUAL" },
    ["V"] = { str = "VISUAL LINE" },
    [""] = { str = "VISUAL BLOCK" },
    ["s"] = { str = "SELECT" },
    ["S"] = { str = "SELECT LINE" },
    [""] = { str = "SELECT BLOCK" },
    ["i"] = { str = "INSERT" },
    ["R"] = { str = "REPLACE" },
    ["c"] = { str = "COMMAND" },
    ["r"] = { str = "PROMPT" },
    ["!"] = { str = "SHELL" },
    ["t"] = { str = "TERMINAL" },
}

local levels = {
    ["Error"] = "E",
    ["Warn"] = "W",
    ["Info"] = "I",
    ["Hint"] = "H",
}

local function mode()
    local current_mode = vim.fn.mode()
    return string.format("%s", modes[current_mode].str):upper(), "StatusLineMode"
end

local function diagnostics()
    local diag = {}

    for level, short in pairs(levels) do
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
        if count > 0 then table.insert(diag, ' ' .. short .. count) end
    end

    return table.concat(diag, '')
end

local function lspinfo()
    if not rawget(vim, "lsp") then
        return ''
    end

    local cur_buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = cur_buf }

    local names = vim.tbl_map(function(c) 
            return c.name or '[Lsp No Name]'
    end, clients)
    local str = table.concat(names, " ")

    return str or "[No LSP]"
end

local function filepath()
    return "%F %m%r "
end

local function fileinfo()
    local info = vim.bo.filetype
    return string.format("%s", info)
end

local function combine(groups)
    local parts = vim.tbl_map(function(g)
        if type(g) == 'string' then return g end
        if type(g) ~= 'table' then return '' end

        local strings = vim.tbl_filter(function(x) return type(x) == 'string' and x ~= '' end, g.strs or {})
        local str = table.concat(strings, ' ')

        if g.hl == nil  then return ' ' .. str .. ' ' end
        if str:len() == 0 then return '%#' .. g.hl .. "#" end

        return string.format("%%#%s# %s ", g.hl, str)
    end, groups)

    return table.concat(parts, "")
end

StatusLine = {}

StatusLine.active = function()
    local mode, mode_hl = mode()
    return combine {
        { hl = mode_hl, strs = { mode } },
        { hl = "StatusLineDevInfo", strs = { lspinfo(), diagnostics() } },
        "%<",
        { hl = "StatusLineFilepath", strs = { filepath() } },
        "%=",
        "%=",
        { hl = "StatusLineFileInfo", strs = { fileinfo() } },
        { hl = "StatusLineLocation", strs = { "%l:%c|%P" } },
    }
end

StatusLine.inactive = function()
    return combine {
        { hl = "StatusLineFilepath", strs = { filepath() } },
        '%=',
        { hl = "StatusLineLocation", strs = { "%l:%c|%P" } },
    }
end

local statusline_group = vim.api.nvim_create_augroup('StatusLine', { clear = true })

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    desc = "Show active statusline",
    callback = function() vim.wo.statusline = '%!v:lua.StatusLine.active()' end,
    group = statusline_group
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
    desc = "Show inactive statusline",
    callback = function() vim.wo.statusline = '%!v:lua.StatusLine.inactive()' end,
    group = statusline_group
})
