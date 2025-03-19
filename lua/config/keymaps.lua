-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", "df", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "df", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "df", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "df", "<Esc>", { noremap = true, silent = true })

-- FZF
--vim.api.nvim_set_keymap(
--  "n",
--  "<C-y>",
--  "<Cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>",
--  { noremap = true, silent = true }
--)

-- Vim Slime
vim.api.nvim_set_keymap("x", "<C-c><C-c>", "<Plug>SlimeRegionSend", {})
vim.api.nvim_set_keymap("n", "<C-c><C-c>", "<Plug>SlimeParagraphSend", {})
vim.api.nvim_set_keymap("n", "<C-c>v", "<Plug>SlimeConfig<CR>", { noremap = true, silent = true })
-- Need to figure out an alternative to this
--vim.api.nvim_set_keymap("n", "<leader>s", "<Plug>SlimeSendCell", { noremap = true, silent = true })

