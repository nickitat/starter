local M = {}

local on_attach = function(client, bufnr)
  -- your usual configuration — options, keymaps, etc
  -- ...

  local augroup_id = vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
  vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_id,
    buffer = bufnr,
    callback = function()
      if client.server_capabilities.documentRangeFormattingProvider then
        local lsp_format_modifications = require("lsp-format-modifications")
        lsp_format_modifications.format_modifications(client, bufnr)
      end
    end,
  })
end

M.on_attach = on_attach
return M
