-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.g.coq_settings = { auto_start = 'shut-up' }

vim.opt.scrolloff = 10
--vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_set_hl(0, 'Comment', { italic = true })

vim.opt.smoothscroll = true
