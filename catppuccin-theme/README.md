# Catppuccin Theme

Soothing pastel theme with multiple flavours. [catppuccin.com](https://catppuccin.com)

## Flavours

| Flavour | Description |
|---------|-------------|
| Latte | Light theme |
| Frappe | Medium dark |
| Macchiato | Dark (default) |
| Mocha | Darkest |

## Color Palette (Macchiato)

| Color     | Hex       |
|-----------|-----------|
| Rosewater | `#f4dbd6` |
| Flamingo  | `#f0c6c6` |
| Pink      | `#f5bde6` |
| Mauve     | `#c6a0f6` |
| Red       | `#ed8796` |
| Maroon    | `#ee99a0` |
| Peach     | `#f5a97f` |
| Yellow    | `#eed49f` |
| Green     | `#a6da95` |
| Teal      | `#8bd5ca` |
| Sky       | `#91d7e3` |
| Sapphire  | `#7dc4e4` |
| Blue      | `#8aadf4` |
| Lavender  | `#b7bdf8` |
| Base      | `#24273a` |

## Installation

### Alacritty

1. Copy `catppuccin-macchiato.toml` to `~/.config/alacritty/`
2. Add to your `alacritty.toml`:
   ```toml
   import = ["~/.config/alacritty/catppuccin-macchiato.toml"]
   ```

For other flavours, download from [github.com/catppuccin/alacritty](https://github.com/catppuccin/alacritty)

### tmux

1. Copy `tmux-theme.conf` to `~/.config/tmux/themes/`
2. Add to your `tmux.conf` (before the TPM run line):
   ```bash
   source-file ~/.config/tmux/themes/tmux-theme.conf
   ```
3. Reload tmux and install plugins: `prefix + I`

See: [github.com/catppuccin/tmux](https://github.com/catppuccin/tmux)

### WezTerm

1. Copy `colors.lua` to `~/.config/wezterm/`
2. Add to your `wezterm.lua`:
   ```lua
   local colors = require("colors")
   config.color_scheme = colors.scheme
   ```
3. For themed status bar, use `colors.palette` and `colors.status_colors()`

To change flavour, edit `colors.scheme` in colors.lua:
- `"Catppuccin Latte"`
- `"Catppuccin Frappe"`
- `"Catppuccin Macchiato"`
- `"Catppuccin Mocha"`

### Neovim

Copy `colorscheme.lua` to `~/.config/nvim/lua/plugins/colorscheme.lua`

To change flavour, edit the `flavour` option:
```lua
opts = {
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
}
```
