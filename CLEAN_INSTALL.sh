#!/bin/bash

# Clean Install Script for Neovim Superbird Configuration
# This script removes all caches and ensures a fresh start

echo "🧹 Cleaning Neovim caches and state..."

# Close any running Neovim instances
echo "⚠️  Please close all Neovim instances before continuing!"
read -p "Press ENTER when ready..."

# Remove lazy.nvim plugin directory
echo "Removing plugin directory..."
rm -rf ~/.local/share/nvim/lazy

# Remove Neovim state
echo "Removing state files..."
rm -rf ~/.local/state/nvim

# Remove Neovim cache
echo "Removing cache files..."
rm -rf ~/.cache/nvim

# Remove mason cache
echo "Removing Mason cache..."
rm -rf ~/.local/share/nvim/mason

echo ""
echo "✅ Clean complete!"
echo ""
echo "Next steps:"
echo "1. Run: nvim"
echo "2. Wait for all plugins to install (2-5 minutes)"
echo "3. Wait for COQ to build (:COQdeps will run automatically)"
echo "4. When you see 'Done!', close Neovim: :qa!"
echo "5. Restart Neovim: nvim"
echo ""
echo "If you see any errors, just restart Neovim again."
echo ""
