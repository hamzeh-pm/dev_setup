return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup({
      default_mappings = true, -- This gives you the keybindings below
      list_opener = "copen", -- Opens a list of all conflicts in the quickfix window
    })
  end,
}
