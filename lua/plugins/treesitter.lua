return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "javascript", "typescript", "python" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
        "nvim-treesitter/playground"
    }
}
