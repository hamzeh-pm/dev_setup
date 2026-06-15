# Changelog

All notable changes to this development setup are documented in this file.

## [Unreleased]

## [2.1.0] - Standardized Dev Environment Setup

### Added
- **Modern CLI Tools section** - Per-OS install commands for `ripgrep`, `fd`, `bat`, `jq`, `git-delta`, `httpie`, `tree`, with a one-line description of each
- **Python: pyenv + uv + pipx section** - Build dependencies per OS, `pyenv` install + shell setup, `uv` install, `pipx` essentials (ruff, mypy, pre-commit, httpie, pgcli, cookiecutter)
- **Node.js section** - Per-OS install, with a heads-up that Mason/LSP installs in Neovim need Node on `$PATH`
- **Containers: Podman / Docker section** - Per-OS picks (Docker Desktop on macOS, Podman on Linux), `podman-compose` note, `docker`/`podman` CLI compatibility tip
- **Expanded zsh plugin list** - Grouped + inline-commented plugins for containers (`docker`, `docker-compose`, `podman`, `kubectl`, `helm`), cloud (`gh`), and quality-of-life (`colored-man-pages`, `command-not-found`, `extract`, `sudo`, `safe-paste`)
- **Linux clipboard helpers** - `pbcopy`/`pbpaste`/`open` aliases in `zshrc-example` (Linux-only, gated on `$OSTYPE`)
- WezTerm keybindings documentation in README
- WezTerm layout presets table in README
- **Extended tool process detection** - WezTerm tab titles now recognize many more tools:
  - Database clients: psql, mysql, redis-cli, mongosh, sqlite3
  - Kubernetes: kubectl, k9s, helm
  - Infrastructure: terraform, ansible
  - JavaScript runtimes: npm, yarn, pnpm, bun, deno
  - System monitoring: htop, btop, top
  - Git, docker-compose, ssh, and language REPLs (ipython, irb, go, cargo, ruby)
- **New layout presets** - `tlay-3-col` (three equal columns, Leader+F3) and `tlay-3-row` (three equal rows, Leader+F6)
- **Tab reordering** - `Leader + {` / `}` to move tabs left/right
- **Alt+l pane navigation** - Quick next pane switching without leader key

### Changed
- Reworked WezTerm layout preset key assignments (F1-F8) for better organization
- Removed mobile, desk, and nvim multi-window layout presets in favor of simpler single-window layouts
- Leader key timeout increased from 1500ms to 2000ms
- Inactive tab dimming adjusted for better contrast
- Inactive pane saturation reduced from 0.9 to 0.8
- tlay-reset now clears tab title on reset
- Synced `wezterm.lua` with live config: removed left-click selection mouse binding, switched Alt+p/n tab cycle to Alt+`[`/`]`, F2 layout split adjusted from 0.5 to 0.4

### Fixed
- WezTerm: guarded `config.color_scheme = colors.scheme` with a nil-check so the config no longer errors when no theme overlay is loaded
- WezTerm: resolved duplicate `[` LEADER binding (kept `[` for ActivateCopyMode, moved tab reordering to `{` / `}`)

## [2.0.0] - Catppuccin Theme & WezTerm Enhancements

### Added
- **Catppuccin theme** - New soothing pastel theme (Macchiato flavour)
- **Auto-apply color scheme** - WezTerm automatically applies color scheme from theme
- **Colored tabs** - WezTerm tabs now use theme accent colors
- **Status bar theming** - WezTerm status bar adapts to theme colors

### Changed
- Reorganized themes into separate overlay directories (`catppuccin-theme/`, `dracula-theme/`, `tokyo-night-theme/`)
- Renamed status bar color keys for clarity
- Reset tab text intensity to normal for inactive tabs

### Fixed
- Removed unused `adjust_brightness` function from catppuccin colors

## [1.5.0] - WezTerm Integration

### Added
- **WezTerm terminal emulator** - Full configuration with built-in multiplexer
- WezTerm color themes (Tokyo Night, Dracula)
- tmux-style keybindings for WezTerm (`Ctrl+b` leader)
- Layout presets via `Leader + F1-F8`
- Quick tab switching with `Alt + 1-9` and `Alt + n/p`
- Workspace management in WezTerm

### Changed
- Updated README with WezTerm installation and setup instructions

## [1.4.0] - tmux Productivity Layouts

### Added
- **tmux layout aliases** - Quick workspace layouts (`tlay-focus`, `tlay-grid`, `tlay-wide`, `tlay-v55`, `tlay-mobile`, `tlay-desk`, `tlay-reset`)
- Auto-attach to tmux session from Alacritty
- Auto-cleanup orphan tmux sessions

### Changed
- Comprehensive README documentation with keybindings tables

## [1.3.0] - Tokyo Night Theme

### Added
- **Tokyo Night theme** for all tools (Alacritty, tmux, Neovim, Powerlevel10k)
- Theme-specific Powerlevel10k configuration

## [1.2.0] - LazyVim & Python Setup

### Added
- LazyVim extra setup configurations
- Python LSP setup for LazyVim
- VSCode Vim keybindings configuration
- `conform` plugin configuration

### Fixed
- Conform plugin configuration issues

## [1.1.0] - Dracula Theme

### Added
- **Dracula theme** for Alacritty, tmux, and Powerlevel10k
- Improved tmux status bar configuration

## [1.0.0] - Initial Release

### Added
- Alacritty terminal configuration
- tmux configuration with TPM (tmux plugin manager)
- Zsh configuration with Oh My Zsh
- Powerlevel10k theme setup
- fzf and fzf-tab integration
- Neovim with LazyVim bootstrap
- vim-tmux-navigator plugin
- Git configuration with useful aliases
- Comprehensive README documentation
