-- Tokyo Night Theme for Neovim (LazyVim)
-- Copy to ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night", -- Options: "night", "storm", "moon", "day"
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
