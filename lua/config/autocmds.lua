-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Somehow fixes wrong goto_location
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Outline",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      local outline = require("symbols-outline")
      local node = outline._current_node()

      vim.api.nvim_win_set_cursor(outline.state.code_win, { node.line + 1, node.character })

      vim.schedule(function()
        --vim.fn.win_gotoid(outline.state.code_win)

        if require("symbols-outline.config").options.auto_close then
          outline.close_outline()
        end
      end)
    end, { buffer = true })
  end,
})

