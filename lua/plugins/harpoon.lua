return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })
        vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end)
        vim.keymap.set("n", "<A-h>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

        vim.keymap.set("n", "<A-j>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-k>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-l>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-;>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<A-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<A-S-N>", function() harpoon:list():next() end)
    end,
}
