return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "ruff",
        "prettier",
        "shfmt",
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    local sources = {
      require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
      require("none-ls.formatting.ruff_format"),
      null_ls.builtins.formatting.prettier.with({ filtetypes = { "json", "yaml", "markdown" } }),
      null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }),
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsb.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
