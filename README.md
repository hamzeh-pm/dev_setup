# Development Machine Setup

A comprehensive guide to setting up a modern terminal environment with Alacritty, tmux, zsh, and Neovim.

## What's Included

- **Terminal**: [Alacritty](https://alacritty.org/) (GPU-accelerated) or [WezTerm](https://wezfurlong.org/wezterm/) (feature-rich)
- **Shell**: Zsh with Oh My Zsh, Powerlevel10k, and plugins
- **Multiplexer**: tmux with useful plugins and layouts
- **Editor**: Neovim with LazyVim
- **Themes**: Separate theme directories (Catppuccin, Dracula, Tokyo Night)

## Repository Structure

```
dev_setup/
├── alacritty.toml      # Base config (theme-free)
├── tmux.conf           # Base config (theme-free)
├── wezterm.lua         # Base config (theme-free)
├── lua/                # Neovim/LazyVim config
│
├── catppuccin-theme/   # Catppuccin theme overlays
│   ├── README.md
│   ├── catppuccin-macchiato.toml  # Alacritty colors
│   ├── tmux-theme.conf
│   ├── colors.lua      # WezTerm colors
│   └── colorscheme.lua # Neovim colorscheme
│
├── dracula-theme/      # Dracula theme overlays
│   ├── README.md
│   ├── dracula.toml
│   ├── tmux-theme.conf
│   ├── colors.lua
│   └── colorscheme.lua
│
└── tokyo-night-theme/  # Tokyo Night theme overlays
    ├── README.md
    ├── tokyo-night.toml
    ├── tmux-theme.conf
    ├── colors.lua
    ├── colorscheme.lua
    └── .p10k.zsh       # Powerlevel10k theme
```

The base configs are theme-free. Apply a theme by importing/sourcing the overlay files from a theme directory. See each theme's README for instructions.

## Table of Contents

- [Modern CLI Tools](#modern-cli-tools)
- [Install Zsh](#install-zsh)
- [Oh My Zsh & Plugins](#install-oh-my-zsh)
- [Alacritty](#install-alacritty)
- [WezTerm](#install-wezterm)
- [tmux](#install-tmux)
- [Neovim & LazyVim](#install-neovim)
- [Python: pyenv + uv + pipx](#python-pyenv--uv--pipx)
- [Node.js](#nodejs)
- [Containers: Podman / Docker](#containers-podman--docker)
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

### Modern CLI Tools

> Modern replacements for classic Unix tools. Used throughout this setup
> (ripgrep & fd power Neovim/LazyVim; bat replaces cat; delta upgrades git diffs).

```bash
# macOS
brew install ripgrep fd bat jq git-delta httpie tree

# Fedora
sudo dnf install ripgrep fd-find bat jq git-delta httpie tree

# Debian/Ubuntu
sudo apt install ripgrep fd-find bat jq git-delta httpie tree
```

| Tool | Replaces | Notes |
|---|---|---|
| `ripgrep` (`rg`) | grep | Fast recursive search, respects .gitignore |
| `fd` | find | Saner syntax; `fd-find` on apt/dnf — binary may be `fdfind` |
| `bat` | cat | Syntax-highlighted with paging |
| `jq` | — | JSON query/transform |
| `git-delta` | git diff | Side-by-side, syntax-highlighted diffs |
| `httpie` (`http`) | curl | Friendlier HTTP client for API testing |
| `tree` | — | Directory tree view |

> On Debian/Fedora `fd` is installed as `fdfind` / `fd-find` — symlink it if you want `fd`:
> `ln -s $(which fdfind) ~/.local/bin/fd`

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

- JetBrains Mono Nerd Font (recommended)
- Fira Code Nerd Font (alternative)

[Download from Nerd Fonts](https://www.nerdfonts.com/font-downloads)

### install oh my zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install Powerlevel10k(optional)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

For themed Powerlevel10k, see the theme directories (e.g., `tokyo-night-theme/.p10k.zsh`).

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
  git                  # Git commands, aliases, and completions
  zsh-syntax-highlighting  # Highlights commands as you type
  zsh-autosuggestions  # Fish-style suggestions from history
  zsh-completions      # Extra completion definitions
  fzf-tab              # fzf-powered tab completion
  tmux                 # tmux helpers + autostart options
  fzf                  # Enables fzf key bindings (Ctrl+R, Ctrl+T)
  history              # `h` alias + enhanced history search
  aliases              # `acs` shows all aliases (searchable)
  direnv               # Per-directory env vars via .envrc
  copypath             # `copypath` copies current dir to clipboard
  copyfile             # `copyfile <f>` copies file contents to clipboard
  virtualenv           # Shows active Python venv in prompt
  pip                  # pip completions
  python               # Python aliases (pyfind, pyclean, etc.)
  # ----- Containers & Kubernetes -----
  docker               # Docker completions + aliases (dps, dki, drun)
  docker-compose       # docker-compose completions + `dco` alias
  podman               # Podman completions (linux-focused)
  kubectl              # kubectl completions + `k` alias
  helm                 # Helm chart manager completions
  # ----- Cloud / GitHub -----
  gh                   # GitHub CLI completions (gh pr/issue/repo)
  # ----- Quality of life -----
  colored-man-pages    # Colorized man pages
  command-not-found    # Suggests the package to install when cmd missing
  extract              # `extract foo.tar.gz` — works for any archive
  sudo                 # ESC ESC prefixes the last command with sudo
  safe-paste           # Prevents accidental execute on multi-line paste
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

### Linux clipboard helpers (optional)

> Linux is missing macOS's `pbcopy` / `pbpaste` / `open`. These are pure
> additions (no shadowing of existing commands).

```bash
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias open='xdg-open'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
```

> Requires `xclip`:
> `sudo dnf install xclip` (Fedora) or `sudo apt install xclip` (Debian/Ubuntu).
> On Wayland use `wl-clipboard` and swap `xclip` → `wl-copy` / `wl-paste`.

> **Why no `cat=bat` / `grep=rg` / `find=fd`?** Install the modern tools and
> call them by their real names. Shadowing classic Unix commands hides which
> binary you're actually running, and the modern tools have different flags —
> silent substitution causes subtle bugs.

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

To apply a theme, copy the color file from a theme directory (e.g., `dracula-theme/dracula.toml`) to `~/.config/alacritty/` and add the import line to your config.

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

To apply a theme, copy `colors.lua` from a theme directory to `~/.config/wezterm/` and add the require line to your config.

### install tmux

```bash
sudo apt install tmux # For Debian/Ubuntu
sudo dnf install tmux # For Fedora
brew install tmux # For macOS
```

**copy** tmux.conf file provided here into **_.config/tmux/tmux.conf_**

To apply a theme, copy `tmux-theme.conf` from a theme directory to `~/.config/tmux/themes/` and source it in your config.

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

### Python: pyenv + uv + pipx

Three tools, one role each — install all three:

- **pyenv** — manages multiple Python versions side by side, lets you pin per-project
- **uv** — Astral's all-in-one replacement for `pip` / `venv` / `pip-tools` (10-100× faster)
- **pipx** — installs Python CLI tools (ruff, black, mypy, pre-commit, …) in isolated venvs so they don't pollute your project envs

#### Build dependencies (Linux only — needed before pyenv compiles a Python)

```bash
# Fedora
sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel \
  sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel \
  gdbm-devel libnsl2-devel

# Debian / Ubuntu
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev
```

macOS uses the system toolchain — no extra build deps needed.

#### Install pyenv

```bash
# macOS
brew install pyenv

# Fedora / Debian / Ubuntu
curl -fsSL https://pyenv.run | bash
```

Add to `~/.zshrc` (the example in this repo doesn't include it by default — enable per-machine):

```bash
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
```

Then install a Python and set it global:

```bash
pyenv install 3.12
pyenv global 3.12
```

#### Install uv

```bash
# All platforms
curl -LsSf https://astral.sh/uv/install.sh | sh

# or via Homebrew on macOS
brew install uv
```

Daily use:

```bash
uv venv                    # create .venv in current dir
uv pip install -r requirements.txt
uv pip install fastapi     # 10-100× faster than pip
uv run python script.py    # run inside the project's venv
```

#### Install pipx + essential CLI tools

```bash
# macOS
brew install pipx

# Fedora
sudo dnf install -y pipx

# Debian / Ubuntu
sudo apt install -y pipx
```

```bash
pipx ensurepath  # adds ~/.local/bin to PATH

# Essentials — each gets its own isolated venv
pipx install ruff           # fast linter + formatter (replaces flake8/black)
pipx install mypy           # static type checker
pipx install pre-commit     # git hook framework
pipx install httpie         # human-friendly curl
pipx install pgcli          # postgres CLI with autocompletion
pipx install cookiecutter   # project scaffolding
```

> Rule of thumb: `pipx` for CLI tools you want available everywhere, `uv` for project dependencies, `pyenv` to pick which Python those tools and projects use.

### Node.js

> **Heads up:** install Node *before* opening Neovim. Mason (LazyVim's LSP/formatter/linter installer) pulls many language servers from npm — without Node on `$PATH`, those installs silently fail and you'll see "command not found" errors deep inside `:Mason`. Several Tree-sitter parsers, Copilot.lua, and `markdown-preview.nvim` also assume Node is present.

```bash
# macOS
brew install node

# Fedora
sudo dnf install -y nodejs npm

# Debian / Ubuntu (current LTS via NodeSource — distro packages are usually too old)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
```

If you juggle Node versions per project, install `nvm` instead — the example `~/.zshrc` in this repo has a commented-out NVM block ready to enable.

### Containers: Podman / Docker

| Platform | Recommended | Notes |
|----------|-------------|-------|
| macOS | Docker Desktop | Podman works too (`brew install podman` + `podman machine init`) but Docker Desktop is friction-free |
| Fedora | Podman | Daemonless, rootless by default, ships with the distro |
| Debian / Ubuntu | Docker Engine or Podman | Both fine; Docker has wider tooling support, Podman is rootless |

```bash
# macOS — Docker Desktop
brew install --cask docker

# Fedora — Podman (usually preinstalled) + compose support
sudo dnf install -y podman podman-compose

# Debian / Ubuntu — Podman
sudo apt install -y podman podman-compose
```

Podman is CLI-compatible with Docker: `alias docker=podman` works for most workflows, and `podman-compose` reads the same `docker-compose.yml` files. The `docker` / `docker-compose` / `podman` zsh plugins in this repo's `zshrc-example` give you completions and aliases for whichever you end up using.

### Git Configuration

**copy** gitconfig file provided here to **_~/.gitconfig_** (or merge with existing)

Includes useful aliases:

```bash
git hist  # Beautiful colored git log with graph
```

Also configures VSCode as the default diff and merge tool.

### Themes

Theme files are organized in separate directories:

- **`catppuccin-theme/`** - Soothing pastel theme (Macchiato flavour)
- **`dracula-theme/`** - Dark theme with purple accents
- **`tokyo-night-theme/`** - Dark theme inspired by Tokyo city lights

Each theme directory contains:
- Color palette files for Alacritty and WezTerm
- tmux theme configuration
- Neovim colorscheme configuration
- README with installation instructions

See each theme's README for detailed setup instructions.

### tmux Keybindings

The default prefix key is `Ctrl+b`. Here are the essential keybindings:

> **WezTerm Users:** The WezTerm multiplexer uses the same `Ctrl+b` leader key and identical keybindings as tmux. WezTerm also adds:
> - `Alt + 1-9` - Quick tab switching (no leader needed)
> - `Alt + n/p` - Quick next/previous tab
> - `Alt + l` - Navigate to next pane
> - `Leader + {` / `}` - Move tab left/right
> - `Leader + F1-F8` - Layout presets (see [WezTerm Layout Presets](#wezterm-layout-presets))

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

#### `tlay-3-col` - Three Column Layout

Three equal vertical columns for multi-file comparison or side-by-side work.

```
┌──────┬──────┬──────┐
│      │      │      │
│  1   │  2   │  3   │
│      │      │      │
└──────┴──────┴──────┘
```

- Three equal 33% columns
- Great for comparing files or running three services

#### `tlay-3-row` - Three Row Layout

Three equal horizontal rows for stacked workflows.

```
┌───────────────────┐
│        1          │
├───────────────────┤
│        2          │
├───────────────────┤
│        3          │
└───────────────────┘
```

- Three equal 33% rows
- Good for code, output, and logs stacked vertically

#### `tlay-reset` - Reset Layout

Kills all panes and windows except the current one and clears the tab title. Use to start fresh.

#### `vact` - Activate Virtual Environment

Quick alias to activate Python virtual environment:

```bash
vact  # equivalent to: source .venv/bin/activate
```

### WezTerm Layout Presets

WezTerm includes layout presets accessible via `Leader + F1-F8`:

| Keybinding | Layout | Description |
|------------|--------|-------------|
| `Leader + F1` | focus | Main left pane with two stacked right panes |
| `Leader + F2` | wide | Wide top pane with split bottom |
| `Leader + F3` | 3-col | Three equal vertical columns |
| `Leader + F4` | grid | 2x2 equal quadrants |
| `Leader + F5` | 55/45 | Simple vertical 55/45 split |
| `Leader + F6` | 3-row | Three equal horizontal rows |
| `Leader + F8` | reset | Close all panes/tabs except current |
