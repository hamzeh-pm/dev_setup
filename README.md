# Development Machine Setup

A comprehensive guide to setting up a modern terminal environment with Alacritty, tmux, zsh, and Neovim.

## What's Included

- **Terminal**: [Alacritty](https://alacritty.org/) (GPU-accelerated) or [WezTerm](https://wezfurlong.org/wezterm/) (feature-rich)
- **Shell**: Zsh with Oh My Zsh, Powerlevel10k, and plugins
- **Multiplexer**: tmux with useful plugins and layouts
- **Editor**: Neovim with LazyVim
- **Themes**: Dracula (default) or Tokyo Night (alternative)

## Table of Contents

- [Install Zsh](#install-zsh)
- [Oh My Zsh & Plugins](#install-oh-my-zsh)
- [Alacritty](#install-alacritty)
- [WezTerm](#install-wezterm)
- [tmux](#install-tmux)
- [Neovim & LazyVim](#install-neovim)
- [Git Configuration](#git-configuration)
- [tmux Layout Aliases](#tmux-layout-aliases)
- [VSCode Vim Keybindings](#setup-neovim-keybinding-for-vscode)

## Steps

### Install eza

> eza is a modern replacement for ls, used for fzf-tab directory previews

```bash
sudo apt install eza    # For Debian/Ubuntu
sudo dnf install eza    # For Fedora
brew install eza        # For macOS
```

### Install zsh

```bash
sudo apt install zsh -y  # For Debian/Ubuntu
sudo dnf install zsh -y  # For Fedora
```

macOS already has zsh as the default shell

### make zsh your default shell

```bash
chsh -s $(which zsh)
```

### Download and install a Nerd Font

- Fira Code Nerd Font (recommended)
  [Download from Nerd Fonts](https://www.nerdfonts.com/font-downloads)

### install oh my zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install Powerlevel10k(optional)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### install dracula theme for Powerlevel10k(optional)

```bash
git clone https://github.com/dracula/powerlevel10k.git
```

**copy** **_powerlevel10k/files/.p10k.zsh_** to **_~/.p10k.zsh_**

### Install fzf

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Configure Oh My Zsh

```bash
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Oh My Zsh plugins
plugins=(
  git              # Git commands and aliases
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  fzf-tab          # fzf-powered tab completion
  tmux
  fzf
  history          # Enhanced history search
  aliases          # Useful command aliases
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh
```

[complete config example exist here](zshrc-example)

### Zsh Syntax Highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Zsh Autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Zsh Completions

```bash
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

### fzf-tab

```bash
git clone https://github.com/Aloxaf/fzf-tab.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

### Add Customization to .zshrc

```bash
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory       # Append history instead of overwriting
setopt sharehistory        # Share history between sessions
setopt incappendhistory    # Save history incrementally
setopt hist_ignore_dups    # Ignore duplicate commands
setopt hist_reduce_blanks  # Remove extra blanks from commands
```

### fzf-tab options

```bash
# Enable fzf-tab
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab/fzf-tab.plugin.zsh

# Customize fzf-tab behavior
zstyle ':fzf-tab:*' fzf-preview ''
zstyle ':fzf-tab:*' fzf-multi true

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' popup-min-size 120
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # only if you have tmux

# tmux command to get basic split window like this
# --------------------
# |            |     |
# |            |-----|
# |            |     |
# --------------------
alias tmuxlayout="tmux split-window -h -l 35%; tmux split-window -v -l 50%;"
```

### Install alacritty

> Alacritty is my preferred terminal emulator. Other modern terminals will work too with this setup. Alacritty is built in Rust and is blazingly fast.

```bash
sudo apt install alacritty # For Debian/Ubuntu
sudo dnf install alacritty # for Fedora
brew install alacritty # for Mac OS
```

**copy** alacritty.toml file provided here into **_.config/alacritty/alacritty.toml_**

### install dracula theme for alacritty(optional)

```bash
https://github.com/dracula/alacritty/archive/master.zip
```

**copy** dracula.toml file to **_.config/alacritty/_**

### Install WezTerm

> WezTerm is a powerful, cross-platform terminal emulator with built-in multiplexing, GPU-acceleration, and extensive Lua configuration. A great alternative to Alacritty + tmux.

[Download WezTerm](https://wezfurlong.org/wezterm/installation.html)

```bash
# For macOS
brew install --cask wezterm

# For Debian/Ubuntu
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm

# For Fedora
sudo dnf copr enable wezfurlong/wezterm-nightly
sudo dnf install wezterm
```

**copy** `wezterm.lua` file provided here to **_~/.wezterm.lua_** or **_~/.config/wezterm/wezterm.lua_**

**copy** `colors/dracula.toml` file to **_~/.config/wezterm/colors/_** for the Dracula color scheme

### install tmux

```bash
sudo apt install tmux # For Debian/Ubuntu
sudo dnf install tmux # For Fedora
brew install tmux # For macOS
```

**copy** tmux.conf file provided here into **_.config/tmux/tmux.conf_**

### tpm(tmux package manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

then do **ctrl + b (tmux prefix)** + **I(capital I)**

### install neovim

```bash
sudo apt install neovim # For Debian/Ubuntu !important: in ubuntu use snap store for installation for better versioning
sudo dnf install neovim # For Fedora !important: in fedora use flatpack for installation for better versioning
brew install neovim # For Mac OS
```

### install LazyVim

> LazyVim is bootstraping package install package manager and some necessary packages and configurations
> you can read about it in [lazyvim website](https://www.lazyvim.org)

pre requisite

- fzf: fzf (v0.25.1 or greater)
- live grep: ripgrep
- find files: fd

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
```

**copy** lua folder to **_.config/nvim_**

after LazyVim you can add your packages and customize options so easily
**_list of great packages to install and one i usually have with brief description is in the nvim-extra-detailed file_**

### Setup Neovim keybinding for VSCode

> if you prefer to have vim keybinding in your vscode for training or having advantage of faster workflow

Install vim extension by vscodevim for your vscode

Add vim extension extra settings provided in _neovim-lazyvim-vscode-settings.txt_ to your vscode settings file

### Git Configuration

**copy** gitconfig file provided here to **_~/.gitconfig_** (or merge with existing)

Includes useful aliases:

```bash
git hist  # Beautiful colored git log with graph
```

Also configures VSCode as the default diff and merge tool.

### Alternative Theme: Tokyo Night

If you prefer Tokyo Night over Dracula, alternative config files are provided in the `tokyo-night-theme/` folder:

- `tokyo-night-theme/wezterm.lua` - WezTerm config with Tokyo Night colors
- `tokyo-night-theme/alacritty.toml` - Alacritty config
- `tokyo-night-theme/tokyo-night.toml` - Alacritty Tokyo Night color scheme
- `tokyo-night-theme/tmux.conf` - tmux theme config
- `tokyo-night-theme/.p10k.zsh` - Powerlevel10k theme

#### Alacritty Setup

**copy** `tokyo-night-theme/tokyo-night.toml` to **_~/.config/alacritty/tokyo-night.toml_**

**copy** `tokyo-night-theme/alacritty.toml` to **_~/.config/alacritty/alacritty.toml_**

#### Neovim Setup

Tokyo Night is the default colorscheme in LazyVim. The config at `lua/plugins/colorscheme.lua` is already set up with the "night" style.

To change the flavor/style, edit `lua/plugins/colorscheme.lua` and change the `style` option:

```lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",  -- Options: "night", "storm", "moon", "day"
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  }
}
```

Available styles:
- `night` - Dark variant (current default)
- `storm` - Darker variant
- `moon` - Default Tokyo Night style
- `day` - Light theme variant

### tmux Keybindings

The default prefix key is `Ctrl+b`. Here are the essential keybindings:

#### Custom Keybindings (changed from defaults)

| Keybinding | Action | Default |
|------------|--------|---------|
| `prefix` + `\|` | Split window horizontally (side by side) | `prefix` + `%` |
| `prefix` + `-` | Split window vertically (top/bottom) | `prefix` + `"` |
| `prefix` + `r` | Reload tmux config | - |

#### Essential Default Keybindings

| Keybinding | Action |
|------------|--------|
| `prefix` + `c` | Create new window |
| `prefix` + `n` | Next window |
| `prefix` + `p` | Previous window |
| `prefix` + `0-9` | Switch to window by number |
| `prefix` + `w` | List windows |
| `prefix` + `d` | Detach from session |
| `prefix` + `x` | Kill current pane |
| `prefix` + `z` | Toggle pane zoom (fullscreen) |
| `prefix` + `arrow keys` | Navigate between panes |
| `prefix` + `I` | Install TPM plugins |

#### Vim-tmux Navigator (plugin)

Seamless navigation between tmux panes and vim splits:

| Keybinding | Action |
|------------|--------|
| `Ctrl+h` | Move to left pane/split |
| `Ctrl+j` | Move to pane/split below |
| `Ctrl+k` | Move to pane/split above |
| `Ctrl+l` | Move to right pane/split |

### tmux Layout Aliases

The zshrc includes several tmux layout aliases for quick workspace setup. Add these to your `.zshrc`:

#### `tlay-focus` - Focus Layout

Best for focused coding with a log/output panel on the right.

```
┌────────────────┬────────┐
│                │        │
│     Main       ├────────┤
│    (code)      │        │
│                │ logs/  │
└────────────────┴────────┘
```

- Large main pane on the left (65%)
- Two stacked panes on the right (35%)
- Right panes split 70/30 vertically

#### `tlay-grid` - 2x2 Grid Layout

Equal quadrants for monitoring multiple processes or comparing files.

```
┌─────────┬─────────┐
│    1    │    2    │
├─────────┼─────────┤
│    3    │    4    │
└─────────┴─────────┘
```

- Four equal panes
- Great for running tests, servers, logs, and coding simultaneously

#### `tlay-wide` - Wide Layout

Top-heavy layout for code with split bottom for commands/logs.

```
┌───────────────────┐
│                   │
│    Main (code)    │
├─────────┬─────────┤
│  shell  │  logs   │
└─────────┴─────────┘
```

- Wide top pane (50%)
- Two equal bottom panes

#### `tlay-v55` - Vertical 55/45 Split

Simple two-pane vertical split for side-by-side work.

```
┌───────────┬─────────┐
│           │         │
│    55%    │   45%   │
│           │         │
└───────────┴─────────┘
```

- Left pane slightly larger
- Good for code + terminal or code comparison

#### `tlay-mobile` - Mobile Development Layout

Multi-window setup optimized for mobile app development.

```
Window 1: claude.ai   - AI assistant / documentation
Window 2: nvim        - Code editor
Window 3: testing     - Test runner
Window 4: services    - Docker/services (split horizontally)
```

- Creates 4 separate windows
- Services window has horizontal split for multiple services
- Starts on window 1

#### `tlay-desk` - Desktop Development Layout

Compact layout for desktop/web development.

```
Window 1 (code):
┌────────────────┬────────┐
│                │        │
│     Main       ├────────┤
│    (code)      │ term   │
└────────────────┴────────┘

Window 2 (services):
┌─────────┬─────────┐
│ docker  │  logs   │
└─────────┴─────────┘
```

- Main code window with focus layout (65/35 split)
- Separate services window with horizontal split
- Starts on code window

#### `tlay-reset` - Reset Layout

Kills all panes and windows except the current one. Use to start fresh.

#### `vact` - Activate Virtual Environment

Quick alias to activate Python virtual environment:

```bash
vact  # equivalent to: source .venv/bin/activate
```
