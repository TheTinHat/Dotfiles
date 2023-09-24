-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>2", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>3", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>4", function()
    ui.nav_file(4)
end)
vim.keymap.set("n", "<leader>5", function()
    ui.nav_file(5)
end)
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)
