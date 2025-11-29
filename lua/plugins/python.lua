return {
  -- 1. Switch to BasedPyright (better type checking)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false }, -- Disable standard pyright
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard", -- Options: off, basic, standard, strict, all
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        -- Ensure Ruff is managing linting/formatting
        ruff = {
          enabled = true,
          on_attach = function(client)
            -- Disable hover in favor of BasedPyright (Ruff's hover is still maturing)
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },

  -- 2. Adapter for Debugging (nvim-dap-python)
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Point to the debugpy installed by Mason
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_path)
    end,
  },

  -- 3. Virtual Environment Selector
  -- vital for backend dev where you switch venvs often
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python" },
    opts = {
      name = { "venv", ".venv", "env", ".env" }, -- folders to look for
      auto_refresh = false,
    },
    keys = {
      -- Keymap to open VenvSelector to pick a venv
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
