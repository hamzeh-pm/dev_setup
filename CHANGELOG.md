# Changelog

All notable changes to this development setup are documented in this file.

## [Unreleased]

### Added
- WezTerm keybindings documentation in README
- WezTerm layout presets table in README

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
