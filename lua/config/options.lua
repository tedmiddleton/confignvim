-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.mapleader = ","
vim.opt.wrapscan = false
vim.opt.textwidth = 80
--vim.opt.smartindent = false

-- LazyVim auto format
--vim.g.autoformat = false

-- Vim Slime
vim.g.slime_target = "tmux"
vim.g.slime_cell_delimiter = "#%%"
vim.g.slime_no_mappings = 1
