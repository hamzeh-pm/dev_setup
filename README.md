# terminal_setup
how to setup your terminal

## steps
### install zsh
```bash
sudo apt install zsh -y  # For Debian/Ubuntu
sudo dnf install zsh -y  # For Fedora
```

### make zsh your default theme
```bash
chsh -s $(which zsh)
```

### download and copy proper font
- Fira Code Nerd Font (my suggestion)
[download from here](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.nerdfonts.com/font-downloads&ved=2ahUKEwi7xfLt0sSKAxWY0gIHHTzJMisQFnoECBcQAQ&usg=AOvVaw3CWfI_QlL7GqdvUx4iob-O)

### install oh my zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install Powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### install dracula theme for Powerlevel10k
```bash
git clone https://github.com/dracula/powerlevel10k.git
```
**copy** ***powerlevel10k/files/.p10k.zsh*** to ***~/.p10k.zsh***

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
  tmux
  fzf
  history          # Enhanced history search
  aliases          # Useful command aliases
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh
```

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
### install alacritty
```bash
sudo apt install alacritty
```
**copy** alacritty.toml file provided here into ***.config/alacritty/alacritty.toml***

### install dracula theme for alacritty
```bash
https://github.com/dracula/alacritty/archive/master.zip
```

**copy** dracula.toml file to ***.config/alacritty/***

### install tmux
```bash
sudo apt install tmux
```
**copy** tmux.conf file provided here into ***.config/tmux/tmux.conf***

### tpm(tmux package manager)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
then do **ctrl + b (tmux prefix)** + **I(capital I)**


### install neovim
***install neovim from snap store for better versioning

### install LazyVim
pre requisite
- fzf: fzf (v0.25.1 or greater)
- live grep: ripgrep
- find files: fd 

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
```
**copy** lua folder to ***.config/nvim***

after LazyVim you can add your packages and customize options so easily 
***list of great packages to install and one i usually have with brief description is in the nvim-extra-detailed file***