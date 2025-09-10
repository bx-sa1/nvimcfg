return {
    {
        "Vigemus/iron.nvim",
        opts = {
            scala = {
                command = function(meta)
                    function file_exists(name)
                        local f = io.open(name, "r")
                        return f ~= nil and io.close(f)
                    end

                    if file_exists("deps.sc") then
                        return { "scala-cli", "repl", "deps.sc" }
                    elseif file_exists("deps.scala") then
                        return { "scala-cli", "repl", "deps.scala" }
                    else
                        return { "scala-cli", "repl" }
                    end
                end

            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                metals = {}
            }
        }
    }
}
