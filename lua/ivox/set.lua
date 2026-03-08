-- Vim Options --
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- This is used to yank from nvim to the system's clipboard --
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.fillchars:append({ eob = " " })
