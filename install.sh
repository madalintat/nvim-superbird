#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

# ── colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()    { echo -e "${CYAN}  →${NC} $*"; }
success() { echo -e "${GREEN}  ✓${NC} $*"; }
warn()    { echo -e "${YELLOW}  !${NC} $*"; }
error()   { echo -e "${RED}  ✗${NC} $*"; exit 1; }

# ── detect OS ─────────────────────────────────────────────────────────────────
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)  PLATFORM="linux" ;;
  *)      error "Unsupported OS: $OS" ;;
esac

echo ""
echo "  nvim-superbird installer"
echo "  Platform: $OS"
echo ""

# ── helpers ───────────────────────────────────────────────────────────────────
has() { command -v "$1" &>/dev/null; }

install_macos() {
  if ! has brew; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  info "Installing dependencies via Homebrew..."
  brew install neovim node python git lazygit || true
}

install_linux() {
  if has apt-get; then
    info "Installing dependencies via apt..."
    sudo apt-get update -qq
    sudo apt-get install -y neovim git curl build-essential python3 python3-pip
    # Node via NodeSource for a recent version
    if ! has node; then
      info "Installing Node.js..."
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt-get install -y nodejs
    fi
  elif has dnf; then
    info "Installing dependencies via dnf..."
    sudo dnf install -y neovim git curl gcc python3 python3-pip nodejs npm
  elif has pacman; then
    info "Installing dependencies via pacman..."
    sudo pacman -Syu --noconfirm neovim git curl python python-pip nodejs npm
  elif has snap; then
    info "Installing Neovim via snap..."
    sudo snap install nvim --classic
    sudo apt-get install -y git curl build-essential python3 python3-pip nodejs npm 2>/dev/null || true
  else
    error "No supported package manager found (apt, dnf, pacman, snap)."
  fi

  # lazygit
  if ! has lazygit; then
    info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
  fi
}

# ── install system deps ────────────────────────────────────────────────────────
if [ "$PLATFORM" = "macos" ]; then
  install_macos
else
  install_linux
fi

# verify nvim is available and new enough
has nvim || error "Neovim install failed or not in PATH."

NVIM_VER="$(nvim --version | head -1 | awk '{print $2}' | sed 's/^v//')"
NVIM_MAJOR="$(echo "$NVIM_VER" | cut -d. -f1)"
NVIM_MINOR="$(echo "$NVIM_VER" | cut -d. -f2)"
if [ "$NVIM_MAJOR" -lt 1 ] && [ "$NVIM_MINOR" -lt 10 ]; then
  error "Neovim $NVIM_VER found, but this config requires >= 0.10 (uses vim.uv, lazydev)."
fi
success "Neovim $NVIM_VER ready"

# ── backup existing config ────────────────────────────────────────────────────
if [ -d "$NVIM_CONFIG" ] && [ ! -L "$NVIM_CONFIG" ]; then
  BACKUP="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
  warn "Existing config found — backing up to $BACKUP"
  mv "$NVIM_CONFIG" "$BACKUP"
fi

# ── copy config ───────────────────────────────────────────────────────────────
info "Installing config to $NVIM_CONFIG..."
cp -r "$REPO_DIR" "$NVIM_CONFIG"
success "Config installed"

# ── headless plugin bootstrap ─────────────────────────────────────────────────
info "Bootstrapping plugins (this takes a couple of minutes on first run)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
success "Plugins installed"

info "Updating treesitter parsers..."
nvim --headless "+TSUpdateSync" +qa 2>/dev/null || true
success "Parsers updated"

# ── done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}  All done!${NC}"
echo ""
echo "  Run: nvim"
echo "  On first open, Mason will install LSP servers in the background."
if [ "$PLATFORM" = "macos" ]; then
  echo ""
  echo "  ${YELLOW}Kitty users:${NC} make sure ctrl+h/j/k/l pass through to Neovim"
  echo "  (they should NOT be bound to neighboring_window in kitty.conf)."
fi
echo ""
