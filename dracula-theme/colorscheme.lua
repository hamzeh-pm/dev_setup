-- Dracula Theme for Neovim (LazyVim)
-- Copy to ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    opts = {
      transparent_bg = true,
      italic_comment = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
