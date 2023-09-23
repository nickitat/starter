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
map({ "n", "x" }, "<Leader>rf", ":FzfLua git_files<cr>")
map({ "n", "x" }, "<Leader>rh", ":FzfLua search_history<cr>")
map({ "n", "x" }, "<Leader>rk", ":FzfLua keymaps<cr>")
map({ "n", "x" }, "<Leader>rl", ":FzfLua lines<cr>")
map({ "n", "x" }, "<Leader>rn", ":FzfLua live_grep_native<cr>")
map({ "n", "x" }, "<Leader>rs", ":FzfLua lsp_live_workspace_symbols<cr>")
map({ "n", "x" }, "<Leader>rr", ":FzfLua lsp_references<cr>")

vim.keymap.set("i", "S-Tab", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")

map({ "n", "x" }, "<Leader>bm", ":BufferLinePick<cr>")
