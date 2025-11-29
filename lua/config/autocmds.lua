-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

local lsp_group = vim.api.nvim_create_augroup("LspStartup", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = lsp_group,
  callback = function()
    -- Check if we are in a Python project
    if vim.fn.glob("pyproject.toml") ~= "" or vim.fn.glob("setup.py") ~= "" then
      -- 1. Create a temporary buffer (listed=false, scratch=true)
      local bufnr = vim.api.nvim_create_buf(false, true)

      -- 2. Set it to python to trigger the LSP
      vim.api.nvim_buf_set_option(bufnr, "filetype", "python")

      -- 3. Wait a moment for LSP to attach, then delete the buffer
      -- Note: basedpyright usually scans the workspace upon attachment,
      -- so workspace symbols will become available shortly after.
      vim.defer_fn(function()
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end, 5000) -- Keep it alive for 5 seconds to ensure attachment
    end
  end,
})
