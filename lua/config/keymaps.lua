-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

--- More convinient jump back/fwd
map({ "n", "v" }, "jb", "<c-o>", {})
map({ "n", "v" }, "jf", "<c-i>", {})
--- Keymaps for yanky
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
map("n", "<c-n>", "<Plug>(YankyCycleForward)")
map("n", "<c-p>", "<Plug>(YankyCycleBackward)")

vim.keymap.set("n", "gh", require("hover").hover, { desc = "hover.nvim", remap = true })
map({ "n", "x" }, "<Leader>rb", ":FzfLua buffers<cr>")
map({ "n", "x" }, "<Leader>rc", ":FzfLua grep_cword<cr>")
map({ "n", "x" }, "<Leader>rd", ":FzfLua lsp_document_symbols<cr>")
map({ "n", "x" }, "<Leader>rf", ":FzfLua git_files<cr>")
map({ "n", "x" }, "<Leader>rh", ":FzfLua search_history<cr>")
map({ "n", "x" }, "<Leader>ri", ":FzfLua lsp_implementations<cr>")
map({ "n", "x" }, "<Leader>rj", ":FzfLua jumps<cr>")
map({ "n", "x" }, "<Leader>rk", ":FzfLua keymaps<cr>")
map({ "n", "x" }, "<Leader>rl", ":FzfLua lines<cr>")
map({ "n", "x" }, "<Leader>rn", ":FzfLua live_grep_native<cr>")
map({ "n", "x" }, "<Leader>rs", ":FzfLua lsp_live_workspace_symbols<cr>")
map({ "n", "x" }, "<Leader>rr", ":FzfLua lsp_references<cr>")
map({ "n", "x" }, "<Leader>rx",
  ":lua require 'fzf-lua'.live_grep_native({ cmd = 'rg --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g !/contrib/ -e' })<cr>")

vim.keymap.set("i", "S-Tab", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")

map({ "n", "x" }, "<Leader>bm", ":BufferLinePick<cr>")
vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })
vim.keymap.set("n", ";;", ":", { desc = "Cmd" })
vim.keymap.set("n", "<leader>cf", "<cmd>let @+ = expand(\"%\")<CR>", { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>cp", "<cmd>let @+ = expand(\"%:p\")<CR>", { desc = "Copy File Path" })
vim.keymap.set('v', 'yc', require('osc52').copy_operator, { expr = true })
-- vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
-- vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
-- vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
-- vim.keymap.set("t", "j", "<Down>")
-- vim.keymap.set("t", "k", "<Up>")
vim.keymap.set({ "v", "n" }, "<Leader>cp", require("actions-preview").code_actions)
--
vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

