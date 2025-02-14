return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- or "basic" for some type checking
                useLibraryCodeForTypes = true, -- Use django-stubs
                stubPath = "", -- Use default type stubs
                diagnosticMode = "openFilesOnly", -- Don't check the entire project
                autoSearchPaths = true, -- Automatically detect dependencies
              },
            },
          },
        },
        pylsp = {},
      },
    },
  },
}
