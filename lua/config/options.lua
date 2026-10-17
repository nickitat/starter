-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.g.coq_settings = { auto_start = 'shut-up' }

vim.opt.scrolloff = 10
--vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_set_hl(0, 'Comment', { italic = true })

vim.opt.smoothscroll = true

-- Set by the `nvim` zsh function: run LSP servers and shell commands in tools.slice, keep the UI in nvimui.slice.
local tools_scope = vim.env.NVIM_TOOLS_SCOPE
if tools_scope then
  vim.opt.shell = tools_scope .. ' ' .. vim.o.shell
  local rpc_start = vim.lsp.rpc.start
  vim.lsp.rpc.start = function(cmd, ...)
    return rpc_start({ tools_scope, unpack(cmd) }, ...)
  end
end
