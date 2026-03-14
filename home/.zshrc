# ── oh-my-zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions docker docker-compose dotnet)
source $ZSH/oh-my-zsh.sh

# ── Editor ───────────────────────────────────────────────────────────────────
NVIM_BIN="$HOME/.local/share/bob/nvim-bin/nvim"
export EDITOR="$NVIM_BIN"
export VISUAL="$NVIM_BIN"
export MANPAGER="nvim +Man!"

# ── Wayland / Display ─────────────────────────────────────────────────────────
export WAYLAND_DISPLAY=wayland-1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_DESKTOP=niri
export DESKTOP_SESSION=gnome
export GTK_USE_PORTAL=1
export DISPLAY=:0
export GDK_DPI_SCALE=0.5

# ── PATH ─────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.local/share/pnpm:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$PATH:/usr/lib/rustup/bin"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.ghcup/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.dotnet/tools"


# ── Docker ───────────────────────────────────────────────────────────────────
export DOCKER_BUILDKIT=1

# ── zoxide ───────────────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ── Libraries (for C++/cmake projects) ───────────────────────────────────────
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/share/pkgconfig
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# ── eza ──────────────────────────────────────────────────────────────────────
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='eza --long -a'
alias ll='eza -lh'
alias la='eza -lAh'
alias l='eza -lah'
alias lt='eza --tree --level=2 --long --icons --git'
alias ltt='eza --tree --level=3 --long --icons --git'
alias lttt='eza --tree --level=4 --long --icons --git'
alias tree='eza --oneline --tree'

# ── Aliases ──────────────────────────────────────────────────────────────────
alias n='nvim'
alias g='git'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias md='mkdir -p'
alias rd='rmdir'
alias dc='docker-compose'
alias venv='source .venv/bin/activate'
alias edit-in-kitty='kitten edit-in-kitty'
