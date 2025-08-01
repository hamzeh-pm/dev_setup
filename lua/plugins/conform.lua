return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format" }, -- Use ruff as the formatter for Python
        },
        formatters = {
          ruff_format = {
            command = "ruff",
            args = { "format", "--stdin-filename", "$FILENAME", "-" },
            stdin = true,
          },
        },
      })
    end,
  },
}
