return {
    "christoomey/vim-tmux-navigator",
    config = function()
        vim.keymap.set("n", "<Tab-h>", ":TmuxNavigateLeft<CR>")
        vim.keymap.set("n", "<Tab-j>", ":TmuxNavigateDown<CR>")
        vim.keymap.set("n", "<Tab-k>", ":TmuxNavigateUp<CR>")
        vim.keymap.set("n", "<Tab-l>", ":TmuxNavigateRight<CR>")
    end,
}
