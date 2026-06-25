return {
  "folke/snacks.nvim",
  opts = {
    -- Global configuration
    -- ... other options ...

    -- Explorer specific configuration
    explorer = {
      hidden = true, -- <--- This is the key setting
      -- You might also want to show files ignored by Git:
      ignored = true,
    },

    -- Configuration for pickers (like file search)
    picker = {
      sources = {
        files = {
          hidden = true,
          -- ignored = true,
        },
        explorer = {
          hidden = true,
          ignored = true,
        },
        -- ... other sources ...
      },
    },
  },
}
