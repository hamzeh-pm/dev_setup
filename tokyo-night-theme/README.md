# Tokyo Night Theme

A dark, elegant theme inspired by the Tokyo city lights at night. [github.com/folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

## Color Palette

| Color   | Hex       |
|---------|-----------|
| Background | `#1a1b26` |
| Foreground | `#c0caf5` |
| Blue    | `#7aa2f7` |
| Magenta | `#bb9af7` |
| Green   | `#9ece6a` |
| Yellow  | `#e0af68` |
| Cyan    | `#7dcfff` |
| Red     | `#f7768e` |

## Installation

### Alacritty

1. Copy `tokyo-night.toml` to `~/.config/alacritty/`
2. Add to your `alacritty.toml`:
   ```toml
   import = ["~/.config/alacritty/tokyo-night.toml"]
   ```

### tmux

1. Copy `tmux-theme.conf` to `~/.config/tmux/themes/`
2. Add to your `tmux.conf` (before the TPM run line):
   ```bash
   source-file ~/.config/tmux/themes/tmux-theme.conf
   ```
3. Reload tmux and install plugins: `prefix + I`

### WezTerm

1. Copy `colors.lua` to `~/.config/wezterm/`
2. Add to your `wezterm.lua`:
   ```lua
   local colors = require("colors")
   config.color_scheme = colors.scheme
   ```
3. For themed status bar, use `colors.palette` and `colors.status_colors()`

### Neovim

Tokyo Night is included in the base setup. The colorscheme is configured in `lua/plugins/colorscheme.lua`.

Available styles (edit `style` option):
- `night` - Dark variant (default)
- `storm` - Darker variant
- `moon` - Default Tokyo Night
- `day` - Light variant

### Powerlevel10k (Zsh)

Copy `.p10k.zsh` to `~/.p10k.zsh`

This includes Tokyo Night colors for the prompt.
