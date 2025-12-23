# Dracula Theme

Dark theme with vibrant purple accents. [draculatheme.com](https://draculatheme.com)

## Color Palette

| Color   | Hex       |
|---------|-----------|
| Background | `#282a36` |
| Foreground | `#f8f8f2` |
| Purple  | `#bd93f9` |
| Pink    | `#ff79c6` |
| Green   | `#50fa7b` |
| Yellow  | `#f1fa8c` |
| Cyan    | `#8be9fd` |
| Red     | `#ff5555` |

## Installation

### Alacritty

1. Copy `dracula.toml` to `~/.config/alacritty/`
2. Add to your `alacritty.toml`:
   ```toml
   import = ["~/.config/alacritty/dracula.toml"]
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

Copy `colorscheme.lua` to `~/.config/nvim/lua/plugins/colorscheme.lua`

### Powerlevel10k (Zsh)

```bash
git clone https://github.com/dracula/powerlevel10k.git
cp powerlevel10k/files/.p10k.zsh ~/.p10k.zsh
```
