-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", ";;", "<Esc>")
vim.keymap.set("n", "<leader>fs", "<cmd>e ~/.typos.toml<cr>", { desc = "Open typos config" })
