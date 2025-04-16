#!/bin/bash

set -euo pipefail

REPO_BASE_URL="https://raw.githubusercontent.com/ramank775/git-utils/main"
SCRIPTS=("git-purge-branches", "git-changes")
INSTALL_DIR="$HOME/.local/bin"

# Ensure ~/.local/bin exists
if [ ! -d "$INSTALL_DIR" ]; then
  echo "🔍 '$INSTALL_DIR' does not exist."
  read -p "❓ Create it and proceed? [y/N] "  yn </dev/tty 
  case "$yn" in
    [Yy]* ) mkdir -p "$INSTALL_DIR" ;;
    * ) echo "❌ Aborting install."; exit 1 ;;
  esac
fi

for script in "${SCRIPTS[@]}"; do
  SCRIPT_NAME="$script.sh"
  LOCAL_PATH="$INSTALL_DIR/$script"
  SCRIPT_URL="$REPO_BASE_URL/scripts/$SCRIPT_NAME"
  GIT_ALIAS_NAME="${script#git-}"

  echo "⬇️  Installing $script..."
  curl -sSL "$SCRIPT_URL" -o "$LOCAL_PATH"
  chmod +x "$LOCAL_PATH"
  echo "✅ Installed $script to $LOCAL_PATH"

  # Add git alias if not already configured
  if ! git config --get alias.$GIT_ALIAS_NAME >/dev/null; then
    git config --global alias.$GIT_ALIAS_NAME "!$LOCAL_PATH"
    echo "✅ Added git alias: git $GIT_ALIAS_NAME"
  else
    echo "ℹ️ Git alias 'git $GIT_ALIAS_NAME' already exists. Skipping."
  fi
done

# Warn if ~/.local/bin is not in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo -e "\n⚠️ '$INSTALL_DIR' is not in your PATH."
  echo "   Add this to your shell config (~/.bashrc, ~/.zshrc, etc):"
  echo "   export PATH=\"\$PATH:$INSTALL_DIR\""
fi

echo -e "\n🎉 All done! Try running one of your new aliases, like: git purge-branches"
